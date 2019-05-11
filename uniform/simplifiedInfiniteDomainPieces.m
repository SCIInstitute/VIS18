% X in [a,b] and Y in [c,d]
% s in [k*X + k*Y + XY]

syms r p k a b c d
pdf = (k^2 + p)/((k+r)^2*(b-a));

% common integrations
I1 =  1/(d-c)*int((r-c)*pdf, r);
I2 = int(pdf,r);

% p1Infinite
r1 = c;
r2 = d;
r3 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  0 - subs(I2, r, r2);
rI = rI1 + rI2;
p1Infinite = simplify(diff(rI,p));

% p2InfiniteA
r1 = (p-k*b)/(k+b);
r2 = d;
r3 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  0 - subs(I2, r, r2);
rI = rI1 + rI2;
p2InfiniteA = simplify(diff(rI,p));

% p2InfiniteB
r1 = (p-k*a)/(k+a);
r2 = d;
r3 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  0 - subs(I2, r, r2);
rI = rI1 + rI2;
p2InfiniteB = simplify(diff(rI,p));

% p3InfiniteA
r1 = (p-k*b)/(k+b);
r2 = inf;
rI =  0 - subs(I2, r, r1);
p3InfiniteA = simplify(diff(rI,p));

% p3InfiniteB
r1 = (p-k*a)/(k+a);
r2 = inf;
rI =  0 - subs(I2, r, r1);
p3InfiniteB = simplify(diff(rI,p));

% p4InfiniteA
r1 = c;
r2 = (p-k*b)/(k+b);
r3 = (p-k*a)/(k+a);
r4 = d;
r5 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I1, r, r4) - subs(I1, r, r3);
rI3 =  0 - subs(I2, r, r4);
rI = rI1 + rI2 + rI3;
p4InfiniteA = simplify(diff(rI,p));

% p4InfiniteB
r1 = c;
r2 = (p-k*a)/(k+a);
r3 = (p-k*b)/(k+b);
r4 = d;
r5 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I1, r, r4) - subs(I1, r, r3);
rI3 =  0 - subs(I2, r, r4);
rI = rI1 + rI2 + rI3;
p4InfiniteB = simplify(diff(rI,p));

% p5InfiniteA
r1 = c;
r2 = (p-k*b)/(k+b);
r3 = (p-k*a)/(k+a);
r4 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  0 - subs(I2, r, r3);
rI = rI1 + rI2;
p5InfiniteA = simplify(diff(rI,p));

% p5InfiniteB
r1 = c;
r2 = (p-k*a)/(k+a);
r3 = (p-k*b)/(k+b);
r4 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  0 - subs(I2, r, r3);
rI = rI1 + rI2;
p5InfiniteB = simplify(diff(rI,p));

% p6InfiniteA
r1 = c;
r2 = d;
r3 = (p-k*b)/(k+b);
r4 = (p-k*a)/(k+a);
r5 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I2, r, r3) - subs(I2, r, r2);
rI3 =  0 - subs(I2, r, r4);
rI = rI1 + rI2 + rI3;
p6InfiniteA = simplify(diff(rI,p));

% p6InfiniteB
r1 = c;
r2 = d;
r3 = (p-k*a)/(k+a);
r4 = (p-k*b)/(k+b);
r5 = inf;
rI1 =  subs(I1, r, r2) - subs(I1, r, r1);
rI2 =  subs(I2, r, r3) - subs(I2, r, r2);
rI3 =  0 - subs(I2, r, r4);
rI = rI1 + rI2 + rI3;
p6InfiniteB = simplify(diff(rI,p));

