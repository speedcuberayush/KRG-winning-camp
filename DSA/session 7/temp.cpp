#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
using namespace std;

void KMPPreprocess(const string &pattern, vector<int> &lps) {
    int length = 0;
    int i = 1;
    lps[0] = 0;
    while (i < pattern.size()) {
        if (pattern[i] == pattern[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length != 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
}

int KMPMatch(const string &text, const string &pattern, const vector<int> &lps) {
    int i = 0, j = 0;
    int count = 0;
    while (i < text.size()) {
        if (pattern[j] == text[i]) {
            i++;
            j++;
        }
        if (j == pattern.size()) {
            count++;
            j = lps[j - 1];
        } else if (i < text.size() && pattern[j] != text[i]) {
            if (j != 0) {
                j = lps[j - 1];
            } else {
                i++;
            }
        }
    }
    return count;
}

void findLargestPalindromicSubstring(const string &s, int &maxLen, int &count) {
    int n = s.size();
    maxLen = 0;
    count = 0;

    for (int center = 0; center < n; ++center) {
        for (int len = 0; center - len >= 0 && center + len < n && s[center - len] == s[center + len]; ++len) {
            int currentLen = 2 * len + 1;
            if (currentLen > maxLen) {
                maxLen = currentLen;
                count = 1;
            } else if (currentLen == maxLen) {
                count++;
            }
        }
        for (int len = 1; center - len + 1 >= 0 && center + len < n && s[center - len + 1] == s[center + len]; ++len) {
            int currentLen = 2 * len;
            if (currentLen > maxLen) {
                maxLen = currentLen;
                count = 1;
            } else if (currentLen == maxLen) {
                count++;
            }
        }
    }
}

int main() {
    int t;
    cin >> t;
    vector<string> inputs(t);
    for (int i = 0; i < t; ++i) {
        cin >> inputs[i];
    }

    for (const string &s : inputs) {
        int maxLen = 0, count = 0;
        findLargestPalindromicSubstring(s, maxLen, count);
        cout << maxLen << " " << count << endl;
    }

    return 0;
}
