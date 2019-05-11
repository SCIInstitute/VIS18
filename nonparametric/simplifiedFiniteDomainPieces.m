% X in [a,b] and Y in [c,d]
% s in [k*X + k*Y + XY]

syms r p k a b c d
pdf = (k^2 + p)/((k+r)^2*(b-a));

% common integrations
I1 =  1/(d-c)*int((r-c)*pdf, r);
I2 = int(pdf,r);

% p1FiniteA
r1 = c;
r2 = (p-k*b)/(k+b);
rI =  subs(I1, r, r2) - subs(I1, r, r1);
p1FiniteA = simplify(diff(rI,p));

% p1FiniteB
r1 = c;
r2 = (p-k*a)/(k+a);
rI =  subs(I1, r, r2) - subs(I1, r, r1);
p1FiniteB = simplify(diff(rI,p));

% p2FiniteA
r1 = c;
r2 = d;
r3 = (p-k*b)/(k+b);
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I2, r, r3) - subs(I2, r, r2);
rI = rI1 + rI2;
p2FiniteA = simplify(diff(rI,p));

% p2FiniteB
r1 = c;
r2 = d;
r3 = (p-k*a)/(k+a);
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I2, r, r3) - subs(I2, r, r2);
rI = rI1 + rI2;
p2FiniteB = simplify(diff(rI,p));

% p3FiniteA
r1 = (p-k*b)/(k+b);
r2 = (p-k*a)/(k+a);
rI =  subs(I1, r, r2) - subs(I1, r, r1);
p3FiniteA = simplify(diff(rI,p));

% p3FiniteB
r1 = (p-k*a)/(k+a);
r2 = (p-k*b)/(k+b);
rI =  subs(I1, r, r2) - subs(I1, r, r1);
p3FiniteB = simplify(diff(rI,p));

% p4FiniteA
r1 = (p-k*b)/(k+b);
r2 = d;
r3 = (p-k*a)/(k+a);
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I2, r, r3) - subs(I2, r, r2);
rI = rI1 + rI2;
p4FiniteA = simplify(diff(rI,p));

% p4FiniteB
r1 = (p-k*a)/(k+a);
r2 = d;
r3 = (p-k*b)/(k+b);
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I2, r, r3) - subs(I2, r, r2);
rI = rI1 + rI2;
p4FiniteB = simplify(diff(rI,p));
