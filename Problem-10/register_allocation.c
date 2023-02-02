#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int valid(int n, int v, int color, int colors[n], int g[][n]);

int coloring(int k, int n, int v, int colors[n], int g[][n]) {
    if (v == n+1) return 1;

    int r = 0;
    for (int c = 1; c <= k; c++) {
        if (valid(n, v, c, colors, g)) {
            colors[v] = c;
            r = coloring(k, n, v+1, colors, g);
            if (r) return 1;
            colors[v] = 0;
        }
    }
}

int valid(int n, int v, int color, int colors[n], int g[][n]) {
    for (int i = 0; i < n; i++) {
        if (g[v][i] == 1 && colors[i] == color) return 0;   
    }
    return 1;
}

int main(){
    int n;
    scanf("%d", &n);
    
    int g[n][n];
    memset(g, 0, n * n * sizeof(int));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%d", &g[i][j]);
        }
    }
    
    int k;
    scanf("%d", &k);

    int colors[n];
    memset(colors, 0, n * sizeof(int));

    
    int r = coloring(k, n, 0, colors, g);

    if (r) {
        for (int i = 0; i < n; i++) {
            printf("%c ", 64 + colors[i]);
        }
        printf("\n");
    }

    return 0;
}