function [c, d] = lpdec(x, h, g)%塔式分解
% LPDEC   Laplacian Pyramid Decomposition
%
%	[c, d] = lpdec(x, h, g)
%
% Input:
%   x:      input image
%   h, g:   two lowpass filters for the Laplacian pyramid
%
% Output:
%   c:      coarse image at half size
%   d:      detail image at full size
%
% See also:	LPREC, PDFBDEC

% Lowpass filter and downsample
xlo = sefilter2(x, h, h, 'per');%对周期延拓后的图像进行低通滤波
c = xlo(1:2:end, 1:2:end);%下采样   
    
% Compute the residual (bandpass) image by upsample, filter, and subtract
% Even size filter needs to be adjusted to obtain perfect reconstruction
adjust = mod(length(g) + 1, 2);

xlo = zeros(size(x));
xlo(1:2:end, 1:2:end) = c;
d = x - sefilter2(xlo, g, g, 'per', adjust * [1, 1]);