import csv
import numpy as np
from caete_module import photo

out = np.zeros((8,12))
tobin = photo.ascii2bin #  subroutine ascii2bin(file_in, file_out, nx1, ny1)
with open('pfts.csv', mode='r') as fh:
    reader = csv.reader(fh, delimiter=',')
    i = 0
    for row in reader:
        ii = 0
        for el in row:
            if i == 0:
                pass
            else:
                if ii == 0:
                    pass
                else:
                    out[ii-1, i-1] = el
            ii += 1
        i += 1
        print(row)

out[1] = out[1] / 1e6
out[5] = out[5] / 100.
out[6] = out[6] / 100.
out[7] = out[7] / 100.

np.savetxt('pft.txt', out, fmt='%.12f')
tobin('pft.txt', 'pft.bin', 12, 8)


