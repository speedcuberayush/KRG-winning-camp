#include <iostream>
using namespace std;

long long VA(int A, int C, int M)
{
    if (A < 0 || C < 0 || M < 0)
        return 0;
    if (A == 1 && C == 0 && M == 0)
        return 1;
    return VC(A - 1, C, M) + VM(A - 1, C, M);
}

long long VC(int A, int C, int M)
{
    if (A < 0 || C < 0 || M < 0)
        return 0;
    if (A == 0 && C == 1 && M == 0)
        return 1;
    return VA(A, C - 1, M) + VM(A, C - 1, M);
}

long long VM(int A, int C, int M)
{
    if (A < 0 || C < 0 || M < 0)
        return 0;
    if (A == 0 && C == 0 && M == 1)
        return 1;
    return VA(A, C, M - 1) + VC(A, C, M - 1);
}

long long V(int A, int C, int M)
{
    if (A < 0 || C < 0 || M < 0)
        return 0;
    if (A == 0 && C == 0 && M == 0)
        return 0;
    return VA(A, C, M) + VC(A, C, M) + VM(A, C, M);
}

int main()
{

    int A, B, C;
    cin >> A >> B >> C;
    cout << V(A, B, C);
    return 0;
}