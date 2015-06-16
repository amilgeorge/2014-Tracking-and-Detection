function [ C ] = estimateCameraPosition( R,T )

C = -R\T;
end

