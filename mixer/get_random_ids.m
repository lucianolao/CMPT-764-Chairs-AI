% CMPT 764 - Final Project
% get_random_ids.m

function [chair_arm_id, chair_back_id, chair_base_id, chair_seat_id] = get_random_ids(chair_ids)
    num_chairs = length(chair_ids);

    if (num_chairs == 1)
        chair_ids_perm = [chair_ids(1), chair_ids(1), chair_ids(1), chair_ids(1)];
    elseif (num_chairs == 2 || num_chairs == 3)
        chair_ids_ext = [chair_ids, chair_ids];
        chair_ids_perm = chair_ids_ext(randperm(length(chair_ids_ext), 4));
    elseif (num_chairs >= 4)
        chair_ids_perm = chair_ids(randperm(num_chairs, 4));
    end

    chair_arm_id = chair_ids_perm(1);
    chair_back_id = chair_ids_perm(2);
    chair_base_id = chair_ids_perm(3);
    chair_seat_id = chair_ids_perm(4);
end
