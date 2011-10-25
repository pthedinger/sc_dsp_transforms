// Copyright (c) 2011, XMOS Ltd, All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

#include "stdio.h"
#include "fft.h"
#include "sine.h"

void fftTest8() {
    int re[8], im[8];
    for(int i = 0; i < 8; i++) {
        re[i] = (i*i*i) & 255;//sinValue(sine_8, i, 8, 8)>>24;
        im[i] = (737*i) & 255; //0; //cosValue(sine_8, i, 8, 8)>>24;
    }
    for(int i = 0; i < 8; i++) {
        printf("%d  %d\n", re[i], im[i]);
    }
    fftTwiddle(re, im, 8);
    fftForward(re, im, 8, sine_8);
    printf("Post FFT\n");
    for(int i = 0; i < 8; i++) {
        printf("%d  %d\n", re[i], im[i]);
    }
    fftTwiddle(re, im, 8);
    fftInverse(re, im, 8, sine_8);
    printf("Post Inverse\n");
    for(int i = 0; i < 8; i++) {
        printf("%d  %d\n", re[i], im[i]);
    }
}

void fftTest32() {
    timer t;
    int t0, t1;

    int re[32], im[32];
    for(int i = 0; i < 32; i++) {
        re[i] = (i*i*i) & 255;//sinValue(sine_32, i, 32, 32)/0x1000000;
        im[i] = (737*i) & 255; //0; //cosValue(sine_32, i, 32, 32)>>24;
    }
    for(int i = 0; i < 32; i++) {
        printf("%d  %d\n", re[i], im[i]);
    }
    fftTwiddle(re, im, 32);
    t :> t0;
    fftForward(re, im, 32, sine_32);
    t :> t1;
    printf("Post FFT (%d)\n", t1-t0);
    for(int i = 0; i < 32; i++) {
        printf("%d  %d\n", re[i], im[i]);
    }
    fftTwiddle(re, im, 32);
    t :> t0;
    fftInverse(re, im, 32, sine_32);
    t :> t1;
    printf("Post Inverse (%d)\n", t1-t0);
    for(int i = 0; i < 32; i++) {
        printf("%d  %d\n", re[i], im[i]);
    }
}

void fftTest1024() {
    timer t;
    int t0, t1;

    int re[1024], im[1024];
    for(int i = 0; i < 1024; i++) {
        re[i] = (i*i*i) & 255;//sinValue(sine_1024, i, 1024, 1024)/0x1000000;
        im[i] = (737*i) & 255; //0; //cosValue(sine_1024, i, 1024, 1024)>>24;
    }
    fftTwiddle(re, im, 1024);
    t :> t0;
    fftForward(re, im, 1024, sine_1024);
    t :> t1;
    printf("Post FFT (%d)\n", t1-t0);
    fftTwiddle(re, im, 1024);
    t :> t0;
    fftInverse(re, im, 1024, sine_1024);
    t :> t1;
    printf("Post Inverse (%d)\n", t1-t0);
}

int main(void) {
    fftTest1024();
    return 0;
}