% CMPT 764 - Final Project
% adjust_chair_parts.m

function [chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts] = adjust_chair_parts(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts)
    if ~isempty(chair_base_pts)
        chair_base_pts = adjust_base(chair_base_pts, chair_seat_pts);
    end    

    if ~isempty(chair_back_pts)
        chair_back_pts = adjust_back(chair_back_pts, chair_seat_pts);
    end

    if ~isempty(chair_arm_pts)
        chair_arm_pts = adjust_arm(chair_arm_pts, chair_back_pts, chair_seat_pts);
    end
end


function [chair_arm_pts] = adjust_arm(chair_arm_pts, chair_back_pts, chair_seat_pts)
    seat_upper_bound = max(chair_seat_pts);
    seat_lower_bound = min(chair_seat_pts);
    seat_center = median(chair_seat_pts);

    %% Scale Chair Arms
    % X-Axis
    arm_upper_bound = max(chair_arm_pts);
    arm_lower_bound = min(chair_arm_pts);
    
    seat_diff = seat_upper_bound - seat_lower_bound;
    arm_diff = arm_upper_bound - arm_lower_bound;
    arm_scale = seat_diff ./ arm_diff;

    if (arm_scale(1) < 1)
        chair_arm_pts(:, 1) = chair_arm_pts(:, 1) * arm_scale(1);
    end
    
    % Y-Axis
    arm_upper_bound = max(chair_arm_pts);
    arm_lower_bound = min(chair_arm_pts);
    
    arm_diff = arm_upper_bound - arm_lower_bound;
    arm_scale = mean(chair_back_pts) ./ arm_diff;

    if (arm_scale(2) < 1)
        chair_arm_pts(:, 2) = chair_arm_pts(:, 2) * arm_scale(2);
    end
    
    % Z-Axis
    arm_upper_bound = max(chair_arm_pts);
    arm_lower_bound = min(chair_arm_pts);
    
    arm_diff = arm_upper_bound - arm_lower_bound;
    arm_scale = seat_diff ./ arm_diff;

    if (arm_scale(3) < 1)
        chair_arm_pts(:, 3) = chair_arm_pts(:, 3) * arm_scale(3);
    end
    
    %% Translate Chair Arms
    arm_lower_bound = min(chair_arm_pts);
    arm_center = mean(chair_arm_pts);
    
    chair_arm_pts(:, 1) = chair_arm_pts(:, 1) + seat_center(1) - arm_center(1);
    chair_arm_pts(:, 2) = chair_arm_pts(:, 2) + seat_center(2) - arm_lower_bound(2);
    chair_arm_pts(:, 3) = chair_arm_pts(:, 3) + seat_center(3) - arm_center(3);
end


function [chair_back_pts] = adjust_back(chair_back_pts, chair_seat_pts)
    seat_upper_bound = max(chair_seat_pts);
    seat_lower_bound = min(chair_seat_pts);
    seat_center = median(chair_seat_pts);
    
    %% Scale Chair Back
    % X-Axis
    back_upper_bound = max(chair_back_pts);
    back_lower_bound = min(chair_back_pts);

    seat_diff = seat_upper_bound - seat_lower_bound;
    back_diff = back_upper_bound - back_lower_bound;
    back_scale = seat_diff ./ back_diff;

    chair_back_pts(:, 1) = chair_back_pts(:, 1) * back_scale(1);
    
    %% Translate Chair Back  
    back_lower_bound = min(chair_back_pts);
    back_center = mean(chair_back_pts);
    
    chair_back_pts(:, 1) = chair_back_pts(:, 1) + seat_center(1) - back_center(1);
    chair_back_pts(:, 2) = chair_back_pts(:, 2) + seat_center(2) - back_lower_bound(2);
    chair_back_pts(:, 3) = chair_back_pts(:, 3) + seat_lower_bound(3) - back_center(3);
end


function [chair_base_pts] = adjust_base(chair_base_pts, chair_seat_pts)
    seat_upper_bound = max(chair_seat_pts);
    seat_lower_bound = min(chair_seat_pts);
    seat_center = median(chair_seat_pts);

    %% Scale Chair Base
    % X-Axis
    base_upper_bound = max(chair_base_pts);
    base_lower_bound = min(chair_base_pts);

    seat_diff = seat_upper_bound - seat_lower_bound;    
    base_diff = base_upper_bound - base_lower_bound;
    base_scale = seat_diff ./ base_diff;

    if (base_scale(1) < 1)
        chair_base_pts(:, 1) = chair_base_pts(:, 1) * base_scale(1);
    end

    % Z-Axis
    base_upper_bound = max(chair_base_pts);
    base_lower_bound = min(chair_base_pts);

    base_diff = base_upper_bound - base_lower_bound;
    base_scale = seat_diff ./ base_diff;
    
    if (base_scale(3) < 1)
        chair_base_pts(:, 3) = chair_base_pts(:, 3) * base_scale(3);
    end
    
    %% Translate Chair Base
    base_upper_bound = max(chair_base_pts);
    base_center = mean(chair_base_pts);

    chair_base_pts(:, 1) = chair_base_pts(:, 1) + seat_center(1) - base_center(1);
    chair_base_pts(:, 2) = chair_base_pts(:, 2) + seat_center(2) - base_upper_bound(2);
    chair_base_pts(:, 3) = chair_base_pts(:, 3) + seat_center(3) - base_center(3);
end
