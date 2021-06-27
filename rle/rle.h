#ifndef RLE_H
#define RLE_H

int rle_compress(int fd_in, int fd_out);
int rle_recover(int fd_in, int fd_out);

#endif // RLE_H