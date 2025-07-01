function Q=transformation(w,i,raan)
R3_w=[cos(w) sin(w) 0;-sin(w) cos(w) 0;0 0 1];
R1_i=[1 0 0; 0 cos(i) sin(i);0 -sin(i) cos(i)];
R3_raan=[cos(raan) sin(raan) 0;-sin(raan) cos(raan) 0;0 0 1];
Q=R3_w*R1_i*R3_raan;
end