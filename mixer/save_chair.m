% CMPT 764 - Final Project
% save_chair.m

function save_chair(chair_arm_pts, chair_back_pts, chair_base_pts, chair_seat_pts, other_pts, chair_part_ids, dir_name)
    fig = figure();

    chair_name = sprintf("%d_%d_%d_%d", chair_part_ids(1), chair_part_ids(2), chair_part_ids(3), chair_part_ids(4));
    chair_all_pts = [chair_arm_pts; chair_back_pts; chair_base_pts; chair_seat_pts; other_pts];
    writematrix(chair_all_pts, sprintf("%s/%s.txt", dir_name, chair_name), "Delimiter", ",");

    if ~isempty(chair_arm_pts)
        pcshow(chair_arm_pts, "m", "MarkerSize", 500);
        hold on;
    end

    if ~isempty(chair_back_pts)
        pcshow(chair_back_pts, "r", "MarkerSize", 500);
        hold on;
    end

    if ~isempty(chair_base_pts)
        pcshow(chair_base_pts, "b", "MarkerSize", 500);
        hold on;
    end

    if ~isempty(chair_seat_pts)
        pcshow(chair_seat_pts, "g", "MarkerSize", 500);
        hold on;
    end

    if ~isempty(other_pts)
        pcshow(other_pts, "c", "MarkerSize", 500);
    end
    
    set(gca, "Visible", "off");
    iptsetpref("ImshowBorder", "tight");
    
    % Front View
    view(0, 90);
    img_name = sprintf("%s/%s_front.jpg", dir_name, chair_name);
    saveas(fig, img_name);
    format_img(img_name);

    % Top View
    view(0, 180);
    img_name = sprintf("%s/%s_top.jpg", dir_name, chair_name);
    saveas(fig, img_name);
    format_img(img_name);

    % Side View
    view(-90, 0);
    camroll(-90);
    img_name = sprintf("%s/%s_side.jpg", dir_name, chair_name);
    saveas(fig, img_name);
    format_img(img_name);

    close(fig);
end


function format_img(img_name)
    img = imread(img_name);
    [h, w, ~] = size(img);
    pad_size = abs(floor((w - h) / 2));
    
    if (w < h)
        img = padarray(img, [0, pad_size], "replicate");
    else
        img = padarray(img, [pad_size, 0], "replicate");
    end
    
    img = imresize(img, [224, 224]);
    imwrite(img, img_name);
end
