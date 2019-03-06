function tracking(base_dir, fmt, threshold, N)
%myFun - Description
%
% Syntax: tracking(input)
%
% Long description
    videoObject = VideoWriter(sprintf('results_tracking/%s.avi', base_dir));
    videoObject.FrameRate = 10;
    open(videoObject);
    time_inteval = 10;
    winSize = 15;
    % filename_base = 'pingpong/-%04d.jpeg'
    files = dir(fullfile(base_dir, sprintf('*.%s', fmt)));
    first_img_name = fullfile(base_dir, files(1).name);
    prev_img = imread(first_img_name);
    [~,r,c] = harris_corner_detector(prev_img, threshold, N);
    h = size(prev_img, 1);
    w = size(prev_img, 2);
    for i = 2:length(files)
        % savename =  sprintf(filename_base, i);
        close all;
        fig = figure;
        set(0, 'CurrentFigure', fig);
        % set(fig, 'Visible', 'off');
        imshow(prev_img);
        hold on
        s = scatter(r, c, 30);
        % set(s, 'Visible', 'off');
        s.MarkerEdgeColor = 'r';
        drawnow;
        % fr = getframe;
        fr = getframe(fig);
        writeVideo(videoObject, fr);
        new_img = imread(fullfile(base_dir, files(i).name));
        [Vx1, Vy1, ~] = lucas_kanade(prev_img, new_img, 'F');
        prev_img = new_img;
        ind_x = min(ceil(r/winSize), size(Vx1, 2));
        ind_y = min(ceil(c/winSize), size(Vx1, 1));
        v_r = Vx1(sub2ind(size(Vx1), ind_y, ind_x));
        v_c = Vy1(sub2ind(size(Vy1), ind_y, ind_x));
        r = r+v_r*time_inteval;
        c = c+v_c*time_inteval;
        r = min(h, max(1, r));
        c = min(size(prev_img, 2), max(1, c));
        hold off
    end
    % filename = path_1(3:end-5); % adjust this to store the input image name if path is changed.
    % savename =  sprintf('./results/lucas-kanade-%d.eps', filename);
    close(videoObject)
end