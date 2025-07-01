function E=kepler_E(e,M)

error = 10e-8;
if M<pi
    E=M+.5*e;
else
    E=M-0.5*e;
    ratio=1;
    while abs(ratio)>error
        ratio=(E-e*sin(E)-M)/(1-e*cos(E));
E=E-ratio;
    end
end