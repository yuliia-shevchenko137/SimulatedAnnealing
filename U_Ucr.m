function [res, b] = U_Ucr (U0_Ucr, p, omega, Gammap, Gammam)
    b = true;
    h_=6.582*10^-16;
    tau = h_/Gammap;
    omega_tau = omega*tau;
    res = U0_Ucr + p * omega_tau;
    if res < 0
        b = false;
        tau = h_/Gammam;
        omega_tau = omega*tau;
        res = U0_Ucr + p * omega_tau; 
    end
end
