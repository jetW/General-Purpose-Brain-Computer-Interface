function [ chopedSignal ] = chopSignal( signal,samplingFrequency )
    time=floor(size(signal,2)/samplingFrequency);
    for second=1:time-1
        c(second+1,:)=(signal((second-1)*samplingFrequency+1:(second)*samplingFrequency)+signal((second)*samplingFrequency+1:(second+1)*samplingFrequency))/2;
    end
    chopedSignal=c(2:end,:);
end

