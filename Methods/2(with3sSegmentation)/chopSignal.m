function [ chopedSignal ] = chopSignal( signal,samplingFrequency )
    time=floor(size(signal,2)/samplingFrequency);
    for second=0:9:time-9
        c(second+1,:)=signal((second)*samplingFrequency+1:(second+9)*samplingFrequency);
    end
    chopedSignal=c(1:end,:);
end

