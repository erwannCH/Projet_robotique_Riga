function [Rx]=RotaX(teta)
Rx=[1 0 0 0;
    0 cosd(teta) -sind(teta) 0;
    0 sind(teta) cosd(teta) 0;
    0 0 0 1];
end