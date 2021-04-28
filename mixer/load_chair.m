% CMPT 764 - Final Project
% load_chair.m

function [chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, other_pts] = load_chair(chair_id)
    chair_dir = "../../PartNet_Chairs_Clean/Chair_Parts/" + chair_id + "/";

    chair_arm_pts = load(chair_dir + "chair_arm_pts.xyz");
    chair_back_pts = load(chair_dir + "chair_back_pts.xyz");
    chair_base_pts = load(chair_dir + "chair_base_pts.xyz");
    chair_seat_pts = load(chair_dir + "chair_seat_pts.xyz");
    other_pts = load(chair_dir + "other_pts.xyz");
end
