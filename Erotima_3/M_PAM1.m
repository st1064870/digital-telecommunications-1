function [out,SER,BER] = MPAM(lin,M,SNR,encoding)
    if ~strcmp(encoding,'bin') && ~strcmp(encoding,'gray')
        error('Encoding should be bin or gray');
    end
%-------------------------MAPPER-------------------------------------------
    k=log2(M);
    Fc=2.5*10^6;    
    Tsym=4*10^(-6);
    Tsample=Tsym/40;
    gt=sqrt(1/2)*10^3;
    sm =zeros(length(lin),1);
    blocks_in=reshape(lin,[],k);    
    if strcmp(encoding,'bin')
        m = bi2de(blocks_in,'left-msb')+1; % lowest value of sm shoul be 1
    else
        m = bi2de(blocks_in,'left-msb');
        m=bin2gray(m,'pam',M)+1;           % lowest value of sm should be 1
    end
%-------------Modulation PAM-----------------------------------------------    
    Es=1;
    if M==4
    A=1/sqrt(5);
    elseif M==8
    A=1/sqrt(21);
    end    
    sm=(m.*2-1-M)*A;
    symbols=size(sm,1);
    s=zeros(symbols*40,1);
    t=(0:Tsample:(Tsym-Tsample))';
    for i=1:symbols
        for j=1:40
            s((i-1)*40+j)=sm(i)*gt*cos(2*pi*Fc*t(j));
        end
    end  
%-----------------------------AWGN-----------------------------------------
    No=Es/(log2(M)*power(10,SNR/10));
    s2=No/2;
    noise=sqrt(s2)*randn(length(m)*40,1);
    r=s+noise;

%---------------------------Demodulation-----------------------------------    
    for i=1:length(r)
        r(i)=r(i)*gt*cos(2*pi*Fc*(i-1)*Tsample)*Tsample;
    end
    
    demodulated=zeros(symbols,1);
    for i=1:symbols
        ind=((i-1)*40)+1;
        demodulated(i)=sum(r(ind:(ind+39)));
    end
%-------------------Decision----------------------------------------------- 
    constellation=zeros(M,1);
    for i=1:M
        constellation(i)=((2*i)-1-M)*A;
    end
    decision=zeros(symbols,1);
    for i=1:symbols
        dist=abs(constellation-demodulated(i));
        [~,ind]=min(dist);
        decision(i)=ind; 
    end
    errorsym=0;
    totalsymb=0;
    for i=1:symbols
        if decision(i)~=m(i)
            errorsym=errorsym+1;
        end
        totalsymb=totalsymb+1;
    end
%---------------------------------Demapper---------------------------------  
    if strcmp(encoding,'bin')
        blocks_out=de2bi(decision-1,k,'left-msb');
    else
        decision=gray2bin(decision-1,'pam',M);
        blocks_out=de2bi(decision,k,'left-msb');
    end
    
    output_sequence=reshape(blocks_out,[],1);
    
 
    k=lin(lin~=output_sequence);
    BER=length(k)/length(lin);
    out=output_sequence;
    SER=errorsym/totalsymb;
end