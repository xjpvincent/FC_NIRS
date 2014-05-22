function [f] = plotTopoMap(data, config, colorbarrange, badChannels, interpMethod, onlyPlotMap) 
% function f = plotMap44(data, config, colorbarrange, badChannels,
% interpMethod, onlyPlotMap) 
% data: a column vector (not row vector) of value of each channel. The value, for example, can be T-value
% config: one of the following values: '4x4', '3x11', '3x5', '3x3', default will be determined from the size of data. 
% colorbarrange: a vector of length two. e.g. [-1 1], default will be auto color bar
% badChannels: channels whose data are bad and want to be excluded from
% plot, e.g. [2,5]. default []
% interpMethod: 'spline', 'linear', 'nearest', 'none'. Default 'spline'
% onlyPlotMap: 0 or 1. default 0. If 1, will not plot colorbar and rotation
% control
%
% based on hb_map44.m in topo
%
% Examples:
%   plotTopoMap([1 zeros(24,1)]);
%   plotTopoMap(randn(24,1));
%   plotTopoMap(randn(24,1), '4x4', [-1 1], [5], 'linear', 1);
%
% Xu Cui
% 2009/06/02


%
% hb_map44
%
% Input  : para,info,para_p,hb_data,hb_graph_h,hb_map_h,Sel_graph
% Output : hb_map_h
% Example: [hb_map_h] = hb_map44(para,info,para_p,hb_data,hb_graph_h,hb_map_h,Sel_graph); 
%*******************************************************
%*               Plot Hb Map44 Function                *
%*                   Shingo Kawasaki                   *
%*                  HITACHI MECICAL                    *
%*******************************************************
% History?F02.11.11 Ver1.01  futahashi KL conversion function is added
% History?F03.05.06 Ver2.00  Isawa     A display is changed into point->sec.
% History?F03.11.19 Ver2.01  Kusabuka?@multi probe 



if(~exist('data'))
    error('You need to input data');
end
if size(data,1) == 1
    data = data';
end

if(~exist('config'))
    if(length(data) == 24)
        config = '4x4';
    elseif(length(data) == 22)
        config = '3x5';
    elseif(length(data) == 52)
        config = '3x11';
    end
end
if(exist('badChannels'))
    for ii=1:length(badChannels)
        data(badChannels(ii)) = nan;
    end
end
if(~exist('interpMethod'))
    interpMethod = 'spline';
end
if ~exist('onlyPlotMap')
    onlyPlotMap = 0;
end


i = 1;
hb_map = data';   
channelPos = [];

if strcmp(config,'3x3')
    [x,y]     = meshgrid(1:1:4);
    [xi,yi]   = meshgrid(1:0.1:4);
    channelPos = [1 3;
                2 4;
                1 2;
                2 3;
                3 4;
                2 2;
                3 4;
                2 1;
                3 2;
                4 3;
                3 1;
                4 2;];
      ml(1,1) =(hb_map(i,3)+hb_map(i,8))/2;
      ml(1,2) = hb_map(i,3);
      ml(1,3) = hb_map(i,1);
      ml(1,4) =(hb_map(i,1)+hb_map(i,2))/2;
      ml(2,1) = hb_map(i,8);	
      ml(2,2) = hb_map(i,6);
      ml(2,3) = hb_map(i,4);
      ml(2,4) = hb_map(i,2);
      ml(3,1) = hb_map(i,11);
      ml(3,2) = hb_map(i,9);
      ml(3,3) = hb_map(i,7);
      ml(3,4) = hb_map(i,5);
      ml(4,1) =(hb_map(i,11)+hb_map(i,12))/2;
      ml(4,2) = hb_map(i,12);
      ml(4,3) = hb_map(i,10);
      ml(4,4) =(hb_map(i,5) +hb_map(i,10))/2;
      
      pol = interp2(x,y,ml,xi,yi,interpMethod);
      
      for a=1:size(pol,1);
         for b=1:size(pol,2);
            if a<11 & b<(-a+11);pol(a,b)=NaN;end;
            if a<11 & b>(a+21);pol(a,b)=NaN;end;
            if a>21 & b<(a-21);pol(a,b)=NaN;end;
            if a>21 & b>(-a+53);pol(a,b)=NaN;end;
         end;
      end;
      
elseif strcmp(config,'4x4')

    [x,y]     = meshgrid(1:1:6);
    [xi,yi]   = meshgrid(1:0.1:6);

    channelPos = [1 4;
                2 5;
                3 6;
                1 3;
                2 4;
                3 5;
                4 6;
                2 3;
                3 4;
                4 5;
                2 2;
                3 3;
                4 4;
                5 5;
                3 2;
                4 3;
                5 4;
                3 1;
                4 2;
                5 3;
                6 4;
                4 1;
                5 2;
                6 3;];
    %******* It turns around the watch at 45??and interpolates. ******* 
    m(1,1) =(hb_map(i,4)+hb_map(i,11)*2+hb_map(i,18))/4;
    m(1,2) =(hb_map(i,4)+hb_map(i,11))/2;
    m(1,3) = hb_map(i,4);
    m(1,4) = hb_map(i,1);
    m(1,5) =(hb_map(i,1)+hb_map(i,2))/2;
    m(1,6) =(hb_map(i,1)+hb_map(i,2)*2+hb_map(i,3))/4;

    m(2,1) =(hb_map(i,11)+hb_map(i,18))/2;	
    m(2,2) = hb_map(i,11);
    m(2,3) = hb_map(i,8);
    m(2,4) = hb_map(i,5);
    m(2,5) = hb_map(i,2);
    m(2,6) =(hb_map(i,2)+hb_map(i,3))/2;

    m(3,1) = hb_map(i,18);
    m(3,2) = hb_map(i,15);
    m(3,3) = hb_map(i,12);
    m(3,4) = hb_map(i,9);
    m(3,5) = hb_map(i,6);
    m(3,6) = hb_map(i,3);

    m(4,1) = hb_map(i,22);
    m(4,2) = hb_map(i,19);
    m(4,3) = hb_map(i,16);
    m(4,4) = hb_map(i,13);
    m(4,5) = hb_map(i,10);
    m(4,6) = hb_map(i,7);

    m(5,1) =(hb_map(i,22)+hb_map(i,23))/2;
    m(5,2) = hb_map(i,23);
    m(5,3) = hb_map(i,20);
    m(5,4) = hb_map(i,17);
    m(5,5) = hb_map(i,14);
    m(5,6) =(hb_map(i,7) +hb_map(i,14))/2;

    m(6,1) =(hb_map(i,22)+hb_map(i,23)*2+hb_map(i,24))/4;
    m(6,2) =(hb_map(i,23) +hb_map(i,24))/2;
    m(6,3) = hb_map(i,24);
    m(6,4) = hb_map(i,21);
    m(6,5) =(hb_map(i,14) +hb_map(i,21))/2;
    m(6,6) =(hb_map(i,7)+hb_map(i,14)*2+hb_map(i,21))/4;

    pol = interp2(x,y,m,xi,yi,interpMethod);
    %pol = griddata(x,y,m,xi,yi,'nearest');

    %'linear'   The line form interpolation (default) of the triangle base  
    %'cubic'    The cubic interpolation of the triangle base
    %'nearest'  Recently, interpolation by the side point 
    %'invdist'  Reverse distance law 

    for a=1:size(pol,1);
     for b=1:size(pol,2);
        if a<21 & b<(-a+21);pol(a,b)=NaN;end;
        if a<21 & b>(a+31);pol(a,b)=NaN;end;
        if a>31 & b<(a-31);pol(a,b)=NaN;end;
        if a>31 & b>(-a+83);pol(a,b)=NaN;end;
     end;
    end;
elseif strcmp(config,'3x11')
    [x,y]     = meshgrid(1:1:12);
    [xi,yi]   = meshgrid(1:0.1:12);
    
    channelPos = [1 3;
                2 4;
                3 5;
                4 6;
                5 7;
                6 8;
                7 9;
                8 10;
                9 11;
                10 12;
                1 2;
                2 3;
                3 4;
                4 5;
                5 6;
                6 7;
                7 8;
                8 9;
                9 10;
                10 11;
                11 12;
                2 2;
                3 3;
                4 4;
                5 5;
                6 6;
                7 7;
                8 8;
                9 9;
                10 10;
                11 11;
                2 1;
                3 2;
                4 3;
                5 4;
                6 5;
                7 6;
                8 7;
                9 8;
                10 9;
                11 10;
                12 11;
                3 1;
                4 2;
                5 3;
                6 4;
                7 5;
                8 6;
                9 7;
                10 8;
                11 9;
                12 10;];
            
    m(1,1) =(hb_map(i,11)+hb_map(i,32))/2;
    m(1,2) = hb_map(i,11);
    m(1,3) = hb_map(i,1);
    m(1,4) =(hb_map(i,1)+hb_map(i,2))/2;
    m(1,5) =(hb_map(i,1)+hb_map(i,2)*2+hb_map(i,3))/4;
    m(1,6) =(hb_map(i,1)+hb_map(i,2)*3+hb_map(i,3)*3+hb_map(i,4))/8;
    m(1,7) =(hb_map(i,1)+hb_map(i,2)*4+hb_map(i,3)*6+hb_map(i,4)*4+hb_map(i,5))/16; %
    m(1,8) =(hb_map(i,1)+hb_map(i,2)*5+hb_map(i,3)*10+hb_map(i,4)*10+hb_map(i,5)*5+hb_map(i,6))/32; %
    m(1,9) =(hb_map(i,1)+hb_map(i,2)*6+hb_map(i,3)*15+hb_map(i,4)*20+hb_map(i,5)*15+hb_map(i,6)*6+hb_map(i,7))/64; %
    m(1,10) =(hb_map(i,1)+hb_map(i,2)*7+hb_map(i,3)*21+hb_map(i,4)*35+hb_map(i,5)*35+hb_map(i,6)*21+hb_map(i,7)*7+hb_map(i,8))/128; %
    m(1,11) =(hb_map(i,1)+hb_map(i,2)*8+hb_map(i,3)*28+hb_map(i,4)*56+hb_map(i,5)*70+hb_map(i,6)*56+hb_map(i,7)*28+hb_map(i,8)*8+hb_map(i,9))/256; %
    m(1,12) =(hb_map(i,1)+hb_map(i,2)*9+hb_map(i,3)*36+hb_map(i,4)*84+hb_map(i,5)*126+hb_map(i,6)*126+hb_map(i,7)*84+hb_map(i,8)*36+hb_map(i,9)*9+hb_map(i,10))/512; %

    m(2,1) =(hb_map(i,32));
    m(2,2) = hb_map(i,22);
    m(2,3) = hb_map(i,12);
    m(2,4) = hb_map(i,2);
    m(2,5) =(hb_map(i,2)+hb_map(i,3))/2;
    m(2,6) =(hb_map(i,2)+hb_map(i,3)*2+hb_map(i,4))/4;
    m(2,7) =(hb_map(i,2)+hb_map(i,3)*3+hb_map(i,4)*3+hb_map(i,5))/8;
    m(2,8) =(hb_map(i,2)+hb_map(i,3)*4+hb_map(i,4)*6+hb_map(i,5)*4+hb_map(i,6))/16; %   
    m(2,9) =(hb_map(i,2)+hb_map(i,3)*5+hb_map(i,4)*10+hb_map(i,5)*10+hb_map(i,6)*5+hb_map(i,7))/32; %
    m(2,10) =(hb_map(i,2)+hb_map(i,3)*6+hb_map(i,4)*15+hb_map(i,5)*20+hb_map(i,6)*15+hb_map(i,7)*6+hb_map(i,8))/64; %
    m(2,11) =(hb_map(i,2)+hb_map(i,3)*7+hb_map(i,4)*21+hb_map(i,5)*35+hb_map(i,6)*35+hb_map(i,7)*21+hb_map(i,8)*7+hb_map(i,9))/128; %
    m(2,12) =(hb_map(i,2)+hb_map(i,3)*8+hb_map(i,4)*28+hb_map(i,5)*56+hb_map(i,6)*70+hb_map(i,7)*56+hb_map(i,8)*28+hb_map(i,9)*8+hb_map(i,10))/256; %

    m(3,1) =(hb_map(i,43));
    m(3,2) = hb_map(i,33);
    m(3,3) = hb_map(i,23);
    m(3,4) = hb_map(i,13);
    m(3,5) = hb_map(i,3);
    m(3,6) =(hb_map(i,3)+hb_map(i,4))/2;
    m(3,7) =(hb_map(i,3)+hb_map(i,4)*2+hb_map(i,5))/4;
    m(3,8) =(hb_map(i,3)+hb_map(i,4)*3+hb_map(i,5)*3+hb_map(i,6))/8;
    m(3,9) =(hb_map(i,3)+hb_map(i,4)*4+hb_map(i,5)*6+hb_map(i,6)*4+hb_map(i,7))/16; %   
    m(3,10) =(hb_map(i,3)+hb_map(i,4)*5+hb_map(i,5)*10+hb_map(i,6)*10+hb_map(i,7)*5+hb_map(i,8))/32; %
    m(3,11) =(hb_map(i,3)+hb_map(i,4)*6+hb_map(i,5)*15+hb_map(i,6)*20+hb_map(i,7)*15+hb_map(i,8)*6+hb_map(i,9))/64; %
    m(3,12) =(hb_map(i,3)+hb_map(i,4)*7+hb_map(i,5)*21+hb_map(i,6)*35+hb_map(i,7)*35+hb_map(i,8)*21+hb_map(i,9)*7+hb_map(i,10))/128; %

    m(4,1) =(hb_map(i,43)+hb_map(i,44))/2;
    m(4,2) =(hb_map(i,44));
    m(4,3) = hb_map(i,34);
    m(4,4) = hb_map(i,24);
    m(4,5) = hb_map(i,14);
    m(4,6) = hb_map(i,4);
    m(4,7) =(hb_map(i,4)+hb_map(i,5))/2;
    m(4,8) =(hb_map(i,4)+hb_map(i,5)*2+hb_map(i,6))/4;
    m(4,9) =(hb_map(i,4)+hb_map(i,5)*3+hb_map(i,6)*3+hb_map(i,7))/8;
    m(4,10) =(hb_map(i,4)+hb_map(i,5)*4+hb_map(i,6)*6+hb_map(i,7)*4+hb_map(i,8))/16; %   
    m(4,11) =(hb_map(i,4)+hb_map(i,5)*5+hb_map(i,6)*10+hb_map(i,7)*10+hb_map(i,8)*5+hb_map(i,9))/32; %
    m(4,12) =(hb_map(i,4)+hb_map(i,5)*6+hb_map(i,6)*15+hb_map(i,7)*20+hb_map(i,8)*15+hb_map(i,9)*3+hb_map(i,10))/64; %

    m(5,1) =(hb_map(i,43)+hb_map(i,44)*2+hb_map(i,45))/4;
    m(5,2) =(hb_map(i,44)+hb_map(i,45))/2;
    m(5,3) =(hb_map(i,45));
    m(5,4) = hb_map(i,35);
    m(5,5) = hb_map(i,25);
    m(5,6) = hb_map(i,15);
    m(5,7) = hb_map(i,5);
    m(5,8) =(hb_map(i,5)+hb_map(i,6))/2;
    m(5,9) =(hb_map(i,5)+hb_map(i,6)*2+hb_map(i,7))/4;
    m(5,10) =(hb_map(i,5)+hb_map(i,6)*3+hb_map(i,7)*3+hb_map(i,8))/8;
    m(5,11) =(hb_map(i,5)+hb_map(i,6)*4+hb_map(i,7)*6+hb_map(i,8)*4+hb_map(i,9))/16; %   
    m(5,12) =(hb_map(i,5)+hb_map(i,6)*5+hb_map(i,7)*10+hb_map(i,8)*10+hb_map(i,9)*5+hb_map(i,10))/32; %

    m(6,1) =(hb_map(i,43)+hb_map(i,44)*3+hb_map(i,45)*3+hb_map(i,46))/8;
    m(6,2) =(hb_map(i,44)+hb_map(i,45)*2+hb_map(i,46))/4;
    m(6,3) =(hb_map(i,45)+hb_map(i,46))/2;
    m(6,4) =(hb_map(i,46));
    m(6,5) = hb_map(i,36);
    m(6,6) = hb_map(i,26);
    m(6,7) = hb_map(i,16);
    m(6,8) = hb_map(i,6);
    m(6,9) =(hb_map(i,6)+hb_map(i,7))/2;
    m(6,10) =(hb_map(i,6)+hb_map(i,7)*2+hb_map(i,8))/4;
    m(6,11) =(hb_map(i,6)+hb_map(i,7)*3+hb_map(i,8)*3+hb_map(i,9))/8;
    m(6,12) =(hb_map(i,6)+hb_map(i,7)*4+hb_map(i,8)*6+hb_map(i,9)*4+hb_map(i,10))/16; %   

    m(7,1) =(hb_map(i,43)+hb_map(i,44)*4+hb_map(i,45)*6+hb_map(i,46)*4+hb_map(i,47))/16; %   
    m(7,2) =(hb_map(i,44)+hb_map(i,45)*3+hb_map(i,46)*3+hb_map(i,47))/8;
    m(7,3) =(hb_map(i,45)+hb_map(i,46)*2+hb_map(i,47))/4;
    m(7,4) =(hb_map(i,46)+hb_map(i,47))/2;
    m(7,5) =(hb_map(i,47));
    m(7,6) = hb_map(i,37);
    m(7,7) = hb_map(i,27);
    m(7,8) = hb_map(i,17);
    m(7,9) = hb_map(i,7);
    m(7,10) =(hb_map(i,7)+hb_map(i,8))/2;
    m(7,11) =(hb_map(i,7)+hb_map(i,8)*2+hb_map(i,9))/4;
    m(7,12) =(hb_map(i,7)+hb_map(i,8)*3+hb_map(i,9)*3+hb_map(i,10))/8;

    m(8,1) =(hb_map(i,43)+hb_map(i,44)*5+hb_map(i,45)*10+hb_map(i,46)*10+hb_map(i,47)*5+hb_map(i,48))/32; %
    m(8,2) =(hb_map(i,44)+hb_map(i,45)*4+hb_map(i,46)*6+hb_map(i,47)*4+hb_map(i,48))/16; %   
    m(8,3) =(hb_map(i,45)+hb_map(i,46)*3+hb_map(i,47)*3+hb_map(i,48))/8;
    m(8,4) =(hb_map(i,46)+hb_map(i,47)*2+hb_map(i,48))/4;
    m(8,5) =(hb_map(i,47)+hb_map(i,48))/2;
    m(8,6) =(hb_map(i,48));
    m(8,7) = hb_map(i,38);
    m(8,8) = hb_map(i,28);
    m(8,9) = hb_map(i,18);
    m(8,10) = hb_map(i,8);
    m(8,11) =(hb_map(i,8)+hb_map(i,9))/2;
    m(8,12) =(hb_map(i,8)+hb_map(i,9)*2+hb_map(i,10))/4;

    m(9,1) =(hb_map(i,43)+hb_map(i,44)*6+hb_map(i,45)*15+hb_map(i,46)*20+hb_map(i,47)*15+hb_map(i,48)*6+hb_map(i,49))/64; %
    m(9,2) =(hb_map(i,44)+hb_map(i,45)*5+hb_map(i,46)*10+hb_map(i,47)*10+hb_map(i,48)*5+hb_map(i,49))/32; %
    m(9,3) =(hb_map(i,45)+hb_map(i,46)*4+hb_map(i,47)*6+hb_map(i,48)*4+hb_map(i,49))/16; %   
    m(9,4) =(hb_map(i,46)+hb_map(i,47)*3+hb_map(i,48)*3+hb_map(i,49))/8;
    m(9,5) =(hb_map(i,47)+hb_map(i,48)*2+hb_map(i,49))/4;
    m(9,6) =(hb_map(i,48)+hb_map(i,49))/2;
    m(9,7) =(hb_map(i,49));
    m(9,8) = hb_map(i,39);
    m(9,9) = hb_map(i,29);
    m(9,10) = hb_map(i,19);
    m(9,11) = hb_map(i,9);
    m(9,12) =(hb_map(i,9)+hb_map(i,10))/2;

    m(10,1) =(hb_map(i,43)+hb_map(i,44)*7+hb_map(i,45)*21+hb_map(i,46)*35+hb_map(i,47)*35+hb_map(i,48)*21+hb_map(i,49)*7+hb_map(i,50))/128; %
    m(10,2) =(hb_map(i,44)+hb_map(i,45)*6+hb_map(i,46)*15+hb_map(i,47)*20+hb_map(i,48)*15+hb_map(i,49)*6+hb_map(i,50))/32; %
    m(10,3) =(hb_map(i,45)+hb_map(i,46)*5+hb_map(i,47)*10+hb_map(i,48)*10+hb_map(i,49)*5+hb_map(i,50))/24; %
    m(10,4) =(hb_map(i,46)+hb_map(i,47)*4+hb_map(i,48)*6+hb_map(i,49)*4+hb_map(i,50))/16; %   
    m(10,5) =(hb_map(i,47)+hb_map(i,48)*3+hb_map(i,49)*3+hb_map(i,50))/8;
    m(10,6) =(hb_map(i,48)+hb_map(i,49)*2+hb_map(i,50))/4;
    m(10,7) =(hb_map(i,49)+hb_map(i,50))/2;
    m(10,8) =(hb_map(i,50));
    m(10,9) = hb_map(i,40);
    m(10,10) = hb_map(i,30);
    m(10,11) = hb_map(i,20);
    m(10,12) = hb_map(i,10);

    m(11,1) =(hb_map(i,43)+hb_map(i,44)*8+hb_map(i,45)*28+hb_map(i,46)*56+hb_map(i,47)*70+hb_map(i,48)*56+hb_map(i,49)*28+hb_map(i,50)*8+hb_map(i,51))/256; %
    m(11,2) =(hb_map(i,44)+hb_map(i,45)*7+hb_map(i,46)*21+hb_map(i,47)*35+hb_map(i,48)*35+hb_map(i,49)*21+hb_map(i,50)*7+hb_map(i,51))/128; %
    m(11,3) =(hb_map(i,45)+hb_map(i,46)*6+hb_map(i,47)*15+hb_map(i,48)*20+hb_map(i,49)*15+hb_map(i,50)*6+hb_map(i,51))/64; %
    m(11,4) =(hb_map(i,46)+hb_map(i,47)*5+hb_map(i,48)*10+hb_map(i,49)*10+hb_map(i,50)*5+hb_map(i,51))/32; %
    m(11,5) =(hb_map(i,47)+hb_map(i,48)*4+hb_map(i,49)*6+hb_map(i,50)*4+hb_map(i,51))/16; %   
    m(11,6) =(hb_map(i,48)+hb_map(i,49)*3+hb_map(i,50)*3+hb_map(i,51))/8;
    m(11,7) =(hb_map(i,49)+hb_map(i,50)*2+hb_map(i,51))/4;
    m(11,8) =(hb_map(i,50)+hb_map(i,51))/2;
    m(11,9) =(hb_map(i,51));
    m(11,10) = hb_map(i,41);
    m(11,11) = hb_map(i,31);
    m(11,12) = hb_map(i,21);

    m(12,1) =(hb_map(i,43)+hb_map(i,44)*9+hb_map(i,45)*36+hb_map(i,46)*84+hb_map(i,47)*126+hb_map(i,48)*126+hb_map(i,49)*84+hb_map(i,50)*36+hb_map(i,51)*9+hb_map(i,52))/512; %
    m(12,2) =(hb_map(i,44)+hb_map(i,45)*8+hb_map(i,46)*28+hb_map(i,47)*56+hb_map(i,48)*70+hb_map(i,49)*56+hb_map(i,50)*28+hb_map(i,51)*8+hb_map(i,52))/256; %
    m(12,3) =(hb_map(i,45)+hb_map(i,46)*7+hb_map(i,47)*21+hb_map(i,48)*35+hb_map(i,49)*35+hb_map(i,50)*21+hb_map(i,51)*7+hb_map(i,52))/128; %
    m(12,4) =(hb_map(i,46)+hb_map(i,47)*6+hb_map(i,48)*15+hb_map(i,49)*20+hb_map(i,50)*15+hb_map(i,51)*6+hb_map(i,52))/64; %
    m(12,5) =(hb_map(i,47)+hb_map(i,48)*5+hb_map(i,49)*10+hb_map(i,50)*10+hb_map(i,51)*5+hb_map(i,52))/32; %
    m(12,6) =(hb_map(i,48)+hb_map(i,49)*4+hb_map(i,50)*6+hb_map(i,51)*4+hb_map(i,52))/16; %   
    m(12,7) =(hb_map(i,49)+hb_map(i,50)*3+hb_map(i,51)*3+hb_map(i,52))/8;
    m(12,8) =(hb_map(i,50)+hb_map(i,51)*2+hb_map(i,52))/4;
    m(12,9) =(hb_map(i,51)+hb_map(i,52))/2;
    m(12,10) =(hb_map(i,52));
    m(12,11) = hb_map(i,42);
    m(12,12) =(hb_map(i,21)+hb_map(i,42))/2;

    pol = interp2(x,y,m,xi,yi,interpMethod);
    %pol = griddata(x,y,m,xi,yi,'nearest');

    %'linear'   The line form interpolation (default) of the triangle base  
    %'cubic'    The cubic interpolation of the triangle base
    %'nearest'  Recently, interpolation by the side point 
    %'invdist'  Reverse distance law 

    for a=1:size(pol,1);
     for b=1:size(pol,2);
        if a<11  & b<(-a+11);pol(a,b)=NaN;end;  % left 
        if a<101 & b>(a+21);pol(a,b)=NaN;end;   % upper
        if a>21  & b<(a-21);pol(a,b)=NaN;end;   % under
        if a>104 & b>(-a+215);pol(a,b)=NaN;end; % right
     end;
    end;
elseif strcmp(config,'3x5')    
    [x,y]     = meshgrid(1:1:6);
    [xi,yi]   = meshgrid(1:0.1:6);
    
    channelPos = [1 3;
                2 4;
                3 5;
                4 6;
                1 2;
                2 3;
                3 4;
                4 5;
                5 6;
                2 2;
                3 3;
                4 4;
                5 5;                
                2 1;
                3 2;
                4 3;
                5 4;
                6 5;               
                3 1;
                4 2;
                5 3;
                6 4;];
            
    m(1,1) =(hb_map(i,5)+hb_map(i,14))/2;
    m(1,2) = hb_map(i,5);
    m(1,3) = hb_map(i,1);
    m(1,4) =(hb_map(i,1)+hb_map(i,2))/2;
    m(1,5) =(hb_map(i,1)+hb_map(i,2)*2+hb_map(i,3))/4;
    m(1,6) =(hb_map(i,1)+hb_map(i,2)*3+hb_map(i,3)*3+hb_map(i,4))/8;

    m(2,1) = hb_map(i,14);	
    m(2,2) = hb_map(i,10);
    m(2,3) = hb_map(i,6);
    m(2,4) = hb_map(i,2);
    m(2,5) =(hb_map(i,2)+hb_map(i,3))/2;
    m(2,6) =(hb_map(i,2)+hb_map(i,3)*2+hb_map(i,4))/4;

    m(3,1) = hb_map(i,19);
    m(3,2) = hb_map(i,15);
    m(3,3) = hb_map(i,11);
    m(3,4) = hb_map(i,7);
    m(3,5) = hb_map(i,3);
    m(3,6) =(hb_map(i,3)+hb_map(i,4))/2;

    m(4,1) =(hb_map(i,19)+hb_map(i,20))/2;
    m(4,2) = hb_map(i,20);
    m(4,3) = hb_map(i,16);
    m(4,4) = hb_map(i,12);
    m(4,5) = hb_map(i,8);
    m(4,6) = hb_map(i,4);

    m(5,1) =(hb_map(i,19)+hb_map(i,20)*2+hb_map(i,21))/4;
    m(5,2) =(hb_map(i,20)+hb_map(i,21))/2;
    m(5,3) = hb_map(i,21);
    m(5,4) = hb_map(i,17);
    m(5,5) = hb_map(i,13);
    m(5,6) = hb_map(i,9);

    m(6,1) =(hb_map(i,19)+hb_map(i,20)*3+hb_map(i,21)*3+hb_map(i,22))/8;
    m(6,2) =(hb_map(i,20)+hb_map(i,21)*2+hb_map(i,22))/4;
    m(6,3) =(hb_map(i,21)+hb_map(i,22))/2;
    m(6,4) = hb_map(i,22);
    m(6,5) = hb_map(i,18);
    m(6,6) =(hb_map(i,9)+hb_map(i,18))/2;

    pol = interp2(x,y,m,xi,yi,interpMethod);
    %pol = griddata(x,y,m,xi,yi,'nearest');

    %'linear'   The line form interpolation (default) of the triangle base  
    %'cubic'    The cubic interpolation of the triangle base
    %'nearest'  Recently, interpolation by the side point 
    %'invdist'  Reverse distance law 

    for a=1:size(pol,1);
     for b=1:size(pol,2);
        if a<11 & b<(-a+11);pol(a,b)=NaN;end;
        if a<31 & b>(a+21);pol(a,b)=NaN;end;
        if a>21 & b<(a-21);pol(a,b)=NaN;end;
        if a>41 & b>(-a+93);pol(a,b)=NaN;end;
     end;
    end;
end

f = gcf;%figure('name','topo plot (Xu Cui)', 'color','w');

if ~onlyPlotMap
    pcolor(pol);
else
    imagesc(pol)
end

%% temporally disabled by xu cui
tx = (channelPos(:,2)-1)*10+1;
ty = (channelPos(:,1)-1)*10+1;
for ii=1:size(channelPos,1)
    channelText(ii,:) = sprintf('%02d', ii);
end
th = text(tx,ty,channelText,'color','w');
data = guidata(f);
data.th = th;
guidata(f,data);    


hold on;
axis square;
axis ij;
axis off;
shading interp;

if(exist('colorbarrange'))
    caxis([colorbarrange(1), colorbarrange(2)])
end


if ~onlyPlotMap
view(-45+90*3,90);    
colorbar


% temporally disabled by xu cui 
uicontrol('Parent',f,...
            'Units','normalized',...
            'Position',[0 0 0.1 0.05],...
            'String','rotate',...
            'Style','push',...
            'Visible','on',...
            'Callback','d = get(gca, ''view'');view(d(1)+90,90)');

uicontrol('Parent',f,...
            'Units','normalized',...
            'Position',[0.1 0.0 0.2 0.05],...
            'String','channel #',...
            'Style','check',...
            'value', 1,...
            'Visible','on',...
            'Callback','data = guidata(gco); th=data.th; v=get(gco, ''value''); if v; set(th, ''visible'', ''on''); else;set(th, ''visible'', ''off'');end');
end        
        