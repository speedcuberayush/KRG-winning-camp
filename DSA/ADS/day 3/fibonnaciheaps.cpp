#include <bits/stdc++.h>
using namespace std;

struct Node
{
    int key;
    int degree;
    Node *parent;
    Node *child;
    Node *prev;
    Node *next;
    bool mark;

    Node(int key)
    {
        this->key = key;
        degree = 0;
        parent = child = NULL;
        prev = next = this;
        mark = false;
    }
};

class FibonacciHeap
{
private:
    Node *min;
    int n;

    void link(Node *y, Node *x)
    {
        y->prev->next = y->next;
        y->next->prev = y->prev;
        y->parent = x;

        if (x->child == NULL)
        {
            x->child = y;
            y->next = y;
            y->prev = y;
        }
        else
        {
            y->prev = x->child;
            y->next = x->child->next;
            x->child->next->prev = y;
            x->child->next = y;
        }

        x->degree++;
        y->mark = false;
    }

    void merge()
    {
        int D = floor(log2(n)) + 1;
        vector<Node *> A(D, NULL);
        vector<Node *> rootList;
        Node *x = min;
        if (x != NULL)
            do
            {
                rootList.push_back(x);
                x = x->next;
            } while (x != min);

        for (auto w : rootList)
        {
            Node *x = w;
            int d = x->degree;
            while (A[d] != NULL)
            {
                Node *y = A[d];
                if (x->key > y->key)
                    swap(x, y);
                link(y, x);
                A[d++] = NULL;
            }
            A[d] = x;
        }

        min = NULL;
        for (auto y : A)
            if (y != NULL)
            {
                if (min == NULL)
                {
                    min = y;
                    min->prev = min->next = min;
                }
                else
                {
                    y->prev = min;
                    y->next = min->next;
                    min->next->prev = y;
                    min->next = y;
                    if (y->key < min->key)
                        min = y;
                }
            }
    }

public:
    FibonacciHeap()
    {
        min = NULL;
        n = 0;
    }

    void insert(int key)
    {
        Node *x = new Node(key);
        if (min == NULL)
            min = x;
        else
        {
            x->prev = min;
            x->next = min->next;
            min->next->prev = x;
            min->next = x;
            if (key < min->key)
                min = x;
        }
        n++;
    }

    int extractMin()
    {
        Node *z = min;
        if (z != NULL)
        {
            if (z->child != NULL)
            {
                vector<Node *> children;
                Node *x = z->child;
                do
                {
                    children.push_back(x);
                    x = x->next;
                } while (x != z->child);

                for (auto x : children)
                {
                    x->prev->next = x->next;
                    x->next->prev = x->prev;
                    x->prev = min;
                    x->next = min->next;
                    min->next->prev = x;
                    min->next = x;
                    x->parent = NULL;
                }
            }

            z->prev->next = z->next;
            z->next->prev = z->prev;

            if (z == z->next)
                min = NULL;

            else
            {
                min = z->next;
                merge();
            }
            n--;
        }
        int key = z->key;
        delete z;
        return key;
    }

    bool isEmpty()
    {
        return min == NULL;
    }

    int getMin()
    {
        return (min) ? min->key : INT_MAX;
    }
};

int main()
{
    FibonacciHeap fh;
    fh.insert(10);
    fh.insert(2);
    fh.insert(15);
    fh.insert(6);
    cout << "Minimum: " << fh.getMin() << endl;
    cout << "Extracting min: " << fh.extractMin() << endl;
    cout << "New minimum: " << fh.getMin() << endl;

    return 0;
}