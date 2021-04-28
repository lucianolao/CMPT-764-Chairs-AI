% CMPT 764 - Final Project
% visualize_pc.m

function visualize_pc(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, other_pts, chair_part_ids)
    figure();

    if ~isempty(chair_arm_pts)
        pcshow(chair_arm_pts, "m", "MarkerSize", 100);
        hold on;
    end

    if ~isempty(chair_back_pts)
        pcshow(chair_back_pts, "r", "MarkerSize", 100);
        hold on;
    end

    if ~isempty(chair_base_pts)
        pcshow(chair_base_pts, "b", "MarkerSize", 100);
        hold on;
    end

    if ~isempty(chair_seat_pts)
        pcshow(chair_seat_pts, "g", "MarkerSize", 100);
        hold on;
    end

    if ~isempty(other_pts)
        pcshow(other_pts, "c", "MarkerSize", 100);
    end

    title_upper = sprintf("Chair Arm ID = %d, Chair Back ID = %d", chair_part_ids(1), chair_part_ids(2));
    title_lower = sprintf("Chair Base ID = %d, Chair Seat ID = %d", chair_part_ids(3), chair_part_ids(4));
    title({title_upper, title_lower});
    
    xlabel("X");
    ylabel("Y");
    zlabel("Z");
end
