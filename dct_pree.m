clc;
clear all;
N=50
for n=1:N
    x(n)=n;
end

stem(x);
title('Original Signal'); xlabel('Samples'); ylabel('Amplitude')
y=zeros(N,1);
for k=1:N
    if k==1
        w(k)=1/sqrt(N);
    else
        w(k)=sqrt(2/N);
    end
    
    for n=1:N
    y(k)=y(k)+x(n)*cos((pi*(n-0.5)*(k-1))/N);
    
    end
    y(k)=y(k)*w(k);
end
z=dct(x);
stem(y);
title('Crafted DCT');

figure;
stem(z);
title('Inbuilt DCT');

%--- sorting and removal of DCT coefficients below threshold

[y_sorted,k]=sort(abs(y));

y_rec=y;
for i=1:N
    if abs(y_rec(i))<0.0031
    y_rec(i)=0;
    end
end


%--- IDCT Computation
a=zeros(N,1);
b=zeros(N,1);
for n=1:N
    
for k=1:N
        if k==1
        w(k)=1/sqrt(N);
    else
        w(k)=sqrt(2/N);
        end
    a(n)=a(n)+w(k)*y(k)*cos((pi)*(n-0.5)*(k-1)/N);%computing idct of original signal
    b(n)=b(n)+w(k)*y_rec(k)*cos((pi)*(n-0.5)*(k-1)/N);%computing idct of compressed signal
end
end
figure;
stem(a);
title('IDCT of original signal');

figure;
stem(b);
title('IDCT of compressed signal');
    