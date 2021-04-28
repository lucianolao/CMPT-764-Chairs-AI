# CMPT 764 - Final Project
# PartNet Dataset Parser

import json
import os


def main(partnet_dir, output_dir):
    if not os.path.exists(partnet_dir):
        raise OSError("Invalid PartNet Dataset Path: " + partnet_dir)

    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    chair_ids = [f.name for f in os.scandir(partnet_dir) if f.is_dir()]
    parse_partnet(partnet_dir, output_dir, chair_ids)


def parse_partnet(partnet_dir, output_dir, chair_ids):
    for chair_id in chair_ids:
        print("Processing Chair %s..." % chair_id)

        chair_dir_path = os.path.join(partnet_dir, chair_id)
        chair_json = open(os.path.join(chair_dir_path, "result.json"), "r")
        chair_json_data = json.load(chair_json)[0]
        chair_arm_ids, chair_back_ids, chair_base_ids, chair_seat_ids, other_ids = get_label_ids(chair_json_data)
        chair_json.close()

        chair_pc_labels = open(os.path.join(chair_dir_path, "point_sample", "label-10000.txt"), "r")
        chair_pc_labels_data = chair_pc_labels.read().splitlines()
        chair_pc_labels.close()

        chair_pc_points = open(os.path.join(chair_dir_path, "point_sample", "pts-10000.txt"), "r")
        chair_pc_points_data = chair_pc_points.read().splitlines()
        chair_pc_points.close()

        write_data(output_dir, chair_id, chair_arm_ids, chair_back_ids, chair_base_ids, chair_seat_ids, other_ids, chair_pc_labels_data, chair_pc_points_data)


def get_label_ids(chair_json_data):
    chair_arm_ids, chair_back_ids, chair_base_ids, chair_seat_ids, other_ids = [], [], [], [], []

    get_label_ids_dfs(chair_json_data, chair_arm_ids, "chair_arm")
    get_label_ids_dfs(chair_json_data, chair_back_ids, "chair_back")
    get_label_ids_dfs(chair_json_data, chair_base_ids, "chair_base")
    get_label_ids_dfs(chair_json_data, chair_seat_ids, "chair_seat")
    get_label_ids_dfs(chair_json_data, other_ids, "other")

    return chair_arm_ids, chair_back_ids, chair_base_ids, chair_seat_ids, other_ids


def get_label_ids_dfs(chair_json_data, label_ids, label, is_child_label=False):
    if chair_json_data["name"] == label or is_child_label:
        label_ids.append(str(chair_json_data["id"]))
        is_child_label = True
    
    if "children" in chair_json_data:
        for child_data in chair_json_data["children"]:
            get_label_ids_dfs(child_data, label_ids, label, is_child_label)


def write_data(output_dir, chair_id, chair_arm_ids, chair_back_ids, chair_base_ids, chair_seat_ids, other_ids, pc_labels, pc_points):
    assert len(pc_labels) == len(pc_points)

    chair_output_dir = os.path.join(output_dir, chair_id)

    if not os.path.exists(chair_output_dir):
        os.makedirs(chair_output_dir)

    chair_arm_pts = open(os.path.join(chair_output_dir, "chair_arm_pts.xyz"), "w")
    chair_back_pts = open(os.path.join(chair_output_dir, "chair_back_pts.xyz"), "w")
    chair_base_pts = open(os.path.join(chair_output_dir, "chair_base_pts.xyz"), "w")
    chair_seat_pts = open(os.path.join(chair_output_dir, "chair_seat_pts.xyz"), "w")
    other_pts = open(os.path.join(chair_output_dir, "other_pts.xyz"), "w")

    for idx in range(len(pc_points)):
        if pc_labels[idx] in chair_arm_ids:
            chair_arm_pts.write("%s\n" % pc_points[idx])
        elif pc_labels[idx] in chair_back_ids:
            chair_back_pts.write("%s\n" % pc_points[idx])
        elif pc_labels[idx] in chair_base_ids:
            chair_base_pts.write("%s\n" % pc_points[idx])
        elif pc_labels[idx] in chair_seat_ids:
            chair_seat_pts.write("%s\n" % pc_points[idx])
        elif pc_labels[idx] in other_ids:
            other_pts.write("%s\n" % pc_points[idx])
        else:
            raise RuntimeError("Invalid Chair Label: %s" % pc_labels[idx])

    chair_arm_pts.close()
    chair_back_pts.close()
    chair_base_pts.close()
    chair_seat_pts.close()
    other_pts.close()


if __name__ == "__main__":
    partnet_dir = os.path.join("..", "..", "PartNet_Chairs", "Chair_Parts")
    output_dir = os.path.join("..", "..", "PartNet_Chairs_Clean", "Chair_Parts")

    main(partnet_dir, output_dir)
