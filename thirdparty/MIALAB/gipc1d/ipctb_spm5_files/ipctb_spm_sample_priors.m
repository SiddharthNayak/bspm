function [s,ds1,ds2,ds3] = ipctb_spm_sample_priors(b,x1,x2,x3,bg)
% Sample prior probability maps
% FORMAT [s,ds1,ds2,ds3] = ipctb_spm_sample_priors(b,x1,x2,x3,bg)
% b           - a cell array containing the tissue probability
%               data (see spm_load_priors)
% x1,x2,x3    - coordinates to sample
% bg          - background intensity (i.e. value for points
%               outside FOV)
% s           - sampled values
% ds1,ds2,ds3 - spatial derivatives of sampled values
%____________________________________________________________________________
% Copyright (C) 2005 Wellcome Department of Imaging Neuroscience

% John Ashburner
% $Id: spm_sample_priors.m 112 2005-05-04 18:20:52Z john $


deg = 3;
lm  = 0;
bg = min(max(bg,lm),(1-lm));
if nargout<=1,
    s      = ipctb_spm_bsplins(b,x1,x2,x3,[deg deg deg  0 0 0]);
    msk    = find(~isfinite(s));
    s(msk) = bg;
else,
    [s,ds1,ds2,ds3] = ipctb_spm_bsplins(b,x1,x2,x3,[deg deg deg  0 0 0]);
    msk      = find(~isfinite(s));
    s(msk)   = bg;
    ds1(msk) = 0;
    ds2(msk) = 0;
    ds3(msk) = 0;
end;