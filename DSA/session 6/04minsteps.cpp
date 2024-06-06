#include <iostream>
#include <string>
using namespace std;

int minCharsToMakePalindrome(const string &A)
{
    int n = A.length();
    int minChars = 0;
    for (int i = 0; i < n / 2; ++i)
    {
        if (A.substr(0, i + 1) == A.substr(n - i - 1, i + 1))
            minChars = n - i - 1;
    }
    return n - 1 - minChars;
}

int main()
{
    string A1 = "ABC";
    string A2 = "AACECAAAA";

    cout << "Minimum characters to insert for A1: " << minCharsToMakePalindrome(A1) << endl;
    cout << "Minimum characters to insert for A2: " << minCharsToMakePalindrome(A2) << endl;

    return 0;
}
