
function y = Test_SMSC(X,label)
% Input£ºX£ºdata matrix
%      label£ºground truth
% Output: y£ºclustering result

v = length(X);   % view number 
k = max(label);  % class number
Fs = cell(v, 1); 
Ss = cell(v, 1); 
n = length(label); 
%==========================
for i = 1 :v
    for  j = 1:n
         X{i}(j,:) = ( X{i}(j,:) - mean( X{i}(j,:) ) ) / std( X{i}(j,:) ) ;
    end
end
for idx = 1:v
   A0 = constructW_PKN(X{idx}',10);
   A0 = A0-diag(diag(A0));
   A10 = (A0+A0')/2;
   D10 = diag(1./sqrt(sum(A10, 2)));
   St = D10*A10*D10;
   [Ft,~,~] = svds(St,k);
   Ss{idx} = St;
   Fs{idx} = Ft;
end
opts.k = k;
[y, obj] = SMSC(Ss,Fs,opts);