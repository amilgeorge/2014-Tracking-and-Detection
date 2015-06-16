I=imread('img_sequence/0000.png');
[Q, P]=ThreeDSiftPoints(I);
figure ;
scatter3(P(1,:), P(2,:), P(3,:));   
hold on ;
 
