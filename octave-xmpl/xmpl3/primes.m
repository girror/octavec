function x=primes(p)
  if nargin != 1
    usage("p = primes(n)");
  endif
  if (p > 100000)
    ## optimization: 1/6 less memory, and much faster (asymptotically)
    ## 100000 happens to be the cross-over point for Paul's machine;
    ## below this the more direct code below is faster.  At the limit
    ## of memory in Paul's machine, this saves .7 seconds out of 7 for
    ## p=3e6.  Hardly worthwhile, but Dirk reports better numbers.
    lenm = floor((p+1)/6);        # length of the 6n-1 sieve
    lenp = floor((p-1)/6);        # length of the 6n+1 sieve
    sievem = ones (1, lenm);      # assume every number of form 6n-1 is prime
    sievep = ones (1, lenp);      # assume every number of form 6n+1 is prime
    for i=1:(sqrt(p)+1)/6         # check up to sqrt(p)
      if (sievem(i))              # if i is prime, eliminate multiples of i
        sievem(7*i-1:6*i-1:lenm) = 0;
        sievep(5*i-1:6*i-1:lenp) = 0;
      endif                       # if i is prime, eliminate multiples of i
      if (sievep(i))
        sievep(7*i+1:6*i+1:lenp) = 0;
        sievem(5*i+1:6*i+1:lenm) = 0;
      endif
    endfor
    x = sort([2, 3, 6*find(sievem)-1, 6*find(sievep)+1]);
  elseif (p > 352) # nothing magical about 352; just has to be greater than 2
    len = floor((p-1)/2);         # length of the sieve
    sieve = ones (1, len);        # assume every odd number is prime
    for i=1:(sqrt(p)-1)/2         # check up to sqrt(p)
      if (sieve(i))               # if i is prime, eliminate multiples of i
        sieve(3*i+1:2*i+1:len) = 0; # do it
      endif
    endfor
    x = [2, 1+2*find(sieve)];     # primes remaining after sieve
  else
    a=[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, \
       61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127,   \
       131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193,\
       197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269,\
       271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349];
    x = a (a<=p);
  endif
endfunction

