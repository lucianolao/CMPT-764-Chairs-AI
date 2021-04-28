% CMPT 764 - Final Project
% generate_chair_samples.m

clear;
close all;
clc;

dir_pos = "./results/positive/";
dir_neg = "./results/negative/";

mkdir(dir_pos);
mkdir(dir_neg);

chair_dir_parts = dir("../../PartNet_Chairs_Clean/Chair_Parts/");
chair_ids = zeros(length(chair_dir_parts) - 2, 1);
num_chairs = length(chair_ids);

for idx = 1 : num_chairs
    chair_ids(idx) = str2double(chair_dir_parts(idx + 2).name);
end

for idx = 1 : num_chairs
    % Generate Positive Sample
    chair_id = chair_ids(idx);
    [chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, ~] = load_chair(chair_id);
    save_chair(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, [], [chair_id, chair_id, chair_id, chair_id], dir_pos);

    % Generate Negative Sample
    [chair_arm_id, chair_back_id, chair_base_id, chair_seat_id] = get_random_ids(chair_ids);
    [chair_arm_pts, ~, ~, ~, ~] = load_chair(chair_arm_id);
    [~, chair_back_pts, ~, ~, ~] = load_chair(chair_back_id);
    [~, ~, chair_base_pts, ~, ~] = load_chair(chair_base_id);
    [~, ~, ~, chair_seat_pts, ~] = load_chair(chair_seat_id);
    save_chair(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, [], [chair_arm_id, chair_back_id, chair_base_id, chair_seat_id], dir_neg);
end
