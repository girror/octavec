function addpath(path)
  p = path;
  app = 0 ;			# Append? Default is 'no'.
    if strcmp(p,"-end") | strcmp(p,"-END") ,
      app = 1 ;
    elseif strcmp(p,"-begin") | strcmp(p,"-BEGIN") ,
      app = 0 ;
    else
      pp = p ;
      ## Not needed
      ## while rindex(pp,"/") == size(pp,2), pp = pp(1:size(pp,2)-1) ; end
      [s,err,m] = stat(pp) ;		# Check for existence
      if err,
	printf("addpath : Stat on %s returns\n %s\n",pp,m);
      elseif index(s.modestr,"d")!=1,
	printf("addpath : >%s< is not a dir (mode=%s)\n",pp, s.modestr);

      elseif  index(s.modestr,"r")!=2, # Asume I'm owner. That's a bug

	printf("addpath : >%s< is not a readable (mode=%s)\n",...
	       pp,s.modestr);
      elseif ! app,
	LOADPATH = [p,':',LOADPATH] ;
      else
	LOADPATH = [LOADPATH,':',p] ;
      end
    end
  
%function addpath(varargin)
%  app = 0 ;			# Append? Default is 'no'.
%  while nargin--,
%    p = va_arg() ;
%    if strcmp(p,"-end") | strcmp(p,"-END") ,
%      app = 1 ;
%    elseif strcmp(p,"-begin") | strcmp(p,"-BEGIN") ,
%      app = 0 ;
%    else
%      pp = p ;
%      ## Not needed
%      ## while rindex(pp,"/") == size(pp,2), pp = pp(1:size(pp,2)-1) ; end
%      [s,err,m] = stat(pp) ;		# Check for existence
%      if err,
%	printf("addpath : Stat on %s returns\n %s\n",pp,m);
%      elseif index(s.modestr,"d")!=1,
%	printf("addpath : >%s< is not a dir (mode=%s)\n",pp, s.modestr);

%      elseif  index(s.modestr,"r")!=2, # Asume I'm owner. That's a bug

%	printf("addpath : >%s< is not a readable (mode=%s)\n",...
%	       pp,s.modestr);
%      elseif ! app,
%	LOADPATH = [p,':',LOADPATH] ;
%      else
%	LOADPATH = [LOADPATH,':',p] ;
%      end
%    end
%  end
