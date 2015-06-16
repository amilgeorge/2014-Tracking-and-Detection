function [ overallEnergy ] = energyFunction(A, rotTraArray, M, m )

  [R, T] = CalcRandT_3(rotTraArray);
    
  rotTra = [R(:, :) T(:)];
  firstPart = A*rotTra*M;

  Normalisepts(firstPart);
  Normalisepts(m);
  
  overallEnergy = 0;
  for i=1:size(M,2)
     overallEnergy = overallEnergy + (norm(firstPart(1:3, i)-m(1:3, i)))^2;
  end
  
end