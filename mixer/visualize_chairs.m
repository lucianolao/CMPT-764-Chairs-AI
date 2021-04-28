% CMPT 764 - Final Project
% visualize_chairs.m

function visualize_chairs(chair_ids)
    for idx = 1 : length(chair_ids)
        chair_id = chair_ids(idx);
        [chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, other_pts] = load_chair(chair_id);
        visualize_pc(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, other_pts, [chair_id, chair_id, chair_id, chair_id]);
    end
end
