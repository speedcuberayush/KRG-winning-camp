#include <bits/stdc++.h>
using namespace std;
void print(vector<int> &arr)
{
    for (auto i : arr)
        cout << i << " ";
    cout << endl;
}
void bubble(vector<int> &arr, int n)
{
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n - i; j++)
            if (arr[j] > arr[j + 1])
                swap(arr[j], arr[j + 1]);
}
void selection(vector<int> &arr, int n)
{
    for (int i = 0; i < n; i++)
    {
        int min = i;
        for (int j = i + 1; j < n; j++)
            if (arr[j] < arr[min])
                min = j;
        swap(arr[min], arr[i]);
    }
}
void insertion(vector<int> &arr, int n)
{
    for (int i = 1; i < n; i++)
    {
        int j = i - 1;
        int key = arr[i];
        while (j >= 0 && arr[j] > key)
            arr[j + 1] = arr[j--];
        arr[j + 1] = key;
    }
}

void quick(vector<int> &arr, int s, int e)
{
    if (s <= e)
    {
        int i = s - 1;
        for (int j = s; j < e; j++)
            if (arr[j] < arr[e])
                swap(arr[++i], arr[j]);
        swap(arr[++i], arr[e]);
        quick(arr, s, i - 1);
        quick(arr, i + 1, e);
    }
}

void merge(vector<int> &arr, int s, int e)
{
    int mid = (s + e) / 2;
    int len1 = mid - s + 1;
    int len2 = e - mid;
    int main = s;

    int *first = new int[len1];
    int *second = new int[len2];
    for (int i = 0; i < len1; i++)
        first[i] = arr[main++];
    for (int i = 0; i < len2; i++)
        second[i] = arr[main++];

    int index1 = 0, index2 = 0;
    main = s;
    while (index1 < len1 && index2 < len2)
        arr[main++] = (first[index1] > second[index2]) ? (second[index2++]) : (first[index1++]);

    while (index1 < len1)
        arr[main++] = first[index1++];
    while (index1 < len2)
        arr[main++] = second[index2++];

    delete[] first;
    delete[] second;
}

void mergeSort(vector<int> &arr, int s, int e)
{
    if (e > s)
    {
        int mid = (s + e) / 2;
        mergeSort(arr, s, mid);
        mergeSort(arr, mid + 1, e);
        merge(arr, s, e);
    }
}
int main()
{
    while (1)
    {

        vector<int> arr = {9, 7, 2, 4, 1, 3, 2, 2, 5, 7};
        int n = arr.size();

        print(arr);
        int choice;
        cout << "Enter your choice: ";
        cin >> choice;
        switch (choice)
        {
        case 1:
            cout << "USING BUBBLE SORT ALGORITHM" << endl;
            bubble(arr, n);
            break;
        case 2:
            cout << "USING SELECTION SORT ALGORITHM" << endl;
            selection(arr, n);
            break;
        case 3:
            cout << "USING INSERTION SORT ALGORITHM" << endl;
            insertion(arr, n);
            break;
        case 4:
            cout << "USING MERGE SORT ALGORITHM" << endl;
            mergeSort(arr, 0, n - 1);
            break;
        case 5:
            cout << "USING QUICK SORT ALGORITHM" << endl;
            quick(arr, 0, n - 1);
            break;

        default:
            break;
        }

        print(arr);
    }
    return 0;
}