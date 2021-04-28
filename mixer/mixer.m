% CMPT 764 - Final Project
% mixer.m

clear;
close all;
clc;

chair_ids = [2585, 2323, 43872];
% chair_ids = [39055, 37529, 40096, 41975, 37546];
% chair_ids = [37107, 39781, 40141, 39426, 35698, 2320, 40546, 37790, 43006, 37108];

num_generated_chairs = 1;
dir_name = "./results/set_a/";
mkdir(dir_name);

% visualize_chairs(chair_ids);

for idx = 1 : num_generated_chairs
    [chair_arm_id, chair_back_id, chair_base_id, chair_seat_id] = get_random_ids(chair_ids);
    % chair_arm_id = 2323;
    % chair_back_id = 2323;
    % chair_base_id = 2323;
    % chair_seat_id = 2323;

    [chair_arm_pts, ~, ~, ~, ~] = load_chair(chair_arm_id);
    [~, chair_back_pts, ~, ~, ~] = load_chair(chair_back_id);
    [~, ~, chair_base_pts, ~, ~] = load_chair(chair_base_id);
    [~, ~, ~, chair_seat_pts, ~] = load_chair(chair_seat_id);

    [chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts] = adjust_chair_parts(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts);

    visualize_pc(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, [], [chair_arm_id, chair_back_id, chair_base_id, chair_seat_id]);
    % save_chair(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, [], [chair_arm_id, chair_back_id, chair_base_id, chair_seat_id], dir_name);
end
