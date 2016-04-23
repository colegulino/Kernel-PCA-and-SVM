% ## Copyright (C) 2015 Cole Gulino
% ## 
% ## This program is free software; you can redistribute it and/or modify it
% ## under the terms of the GNU General Public License as published by
% ## the Free Software Foundation; either version 3 of the License, or
% ## (at your option) any later version.
% ## 
% ## This program is distributed in the hope that it will be useful,
% ## but WITHOUT ANY WARRANTY; without even the implied warranty of
% ## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% ## GNU General Public License for more details.
% ## 
% ## You should have received a copy of the GNU General Public License
% ## along with this program.  If not, see <http://www.gnu.org/licenses/>.
% 
% ## -*- texinfo -*- 
% ## @deftypefn {Function File} {@var{y} =} f (@var{alpha})
% ##
% ## @seealso{}
% ## @end deftypefn
% 
% ## Author: Cole Gulino <cole@cole-ThinkPad-E450>
% ## Created: 2015-11-19

function [y] = f ( alpha, C, K, mu )
  one = ones(1, size(alpha,1));
  if(or(any(alpha <= 0), any(alpha >= C)))
    y = inf;
  else 
    y = 0.5*alpha'*K*alpha - one*alpha - mu*one*log(alpha) - mu*one*log(C - alpha);
  end
end
