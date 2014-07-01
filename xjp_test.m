
tInc = hmrMotionArtifact(d, fs, SD, tIncMan, tMotion, tMask, std_thresh, amp_thresh)
dod=hmrIntensityNormalized(d);
dc=hmrOD2Conc(dod,SD,ppf);
y2=hmrBandpassFilt(y,fs,0.01,0.1);

%dodSpline = hmrMotionCorrectSpline(dod, t, SD, tInc, p)