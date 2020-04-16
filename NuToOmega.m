function res = NuToOmega (nu, units)
  n = nargin;
  if n == 1
    res = 2*pi*nu;
  elseif n == 2
    m=1;
    if units == 'GHz'
      m = m*10^9;
    elseif units == 'THz'
      m = m*10^12;
    elseif units == 'Hz'
      m = 1;
    end
    res = 2*pi*nu*m;
  else
    Exception();
  end
end
