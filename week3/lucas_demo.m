% testing synth images.
[Vx1, Vy1] = lucas_kanade('./synth1.pgm', './synth2.pgm');
% testing sphere images.
[Vx2, Vy2] = lucas_kanade('./sphere1.ppm', './sphere2.ppm');