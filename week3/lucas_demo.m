% testing synth images.
path_1 = './synth1.pgm';
path_2 = './synth2.pgm';
im_1 = imread(path_1);
im_2 = imread(path_2);
[Vx1, Vy1, plot1] = lucas_kanade(im_1, im_2);
filename = path_1(3:end-5); % adjust this to store the input image name if path is changed.
savename =  sprintf('./results/lucas-kanade-%s.eps', filename);
saveas(plot1, savename,'epsc');

% testing sphere images.
path_3 = './sphere1.ppm';
path_4 = './sphere2.ppm';
im_3 = imread(path_3);
im_4 = imread(path_4);
[Vx2, Vy2, plot2] = lucas_kanade(im_3, im_4);
filename = path_3(3:end-5); % adjust this to store the input image name if path is changed.
savename =  sprintf('./results/lucas-kanade-%s.eps', filename);
saveas(plot2, savename,'epsc');
