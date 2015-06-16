function [ imageName ] = getImageName( i )
if(i<10)
formatSpec = 'image_sequence/000%d.png';
else
    formatSpec = 'image_sequence/00%d.png';
    
end

imageName =  sprintf(formatSpec,i);
end