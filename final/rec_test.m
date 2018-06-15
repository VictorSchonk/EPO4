%load()

r = ch_td(rec);
loc1 = loc(r);
maze = createmaze(4);
tic
loc_2 = loc2(r, maze);
toc