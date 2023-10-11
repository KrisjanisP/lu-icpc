---
title: Data structures
category: Jekyll
layout: post
---

## Treap

```cpp

// Implicit segment tree implementation

struct Node{
    int value;
    int cnt;
    int priority;
    Node *left, *right;
    Node(int p) : value(p), cnt(1), priority(gen()), left(NULL), right(NULL) {};
};
 
typedef Node* pnode;
 
int get(pnode q){
    if(!q) return 0;
    return q->cnt;
}
 
void update_cnt(pnode &q){
    if(!q) return;
    q->cnt = get(q->left) + get(q->right) + 1;
}
 
void merge(pnode &T, pnode lef, pnode rig){
    if(!lef) {
        T=rig;
        return;
    }
    if(!rig){
        T=lef;
        return;
    }
    if(lef->priority > rig->priority){
        merge(lef->right, lef->right, rig);
        T = lef;
    }
    else{
        merge(rig->left, lef, rig->left);
        T = rig;
    }
    update_cnt(T);
}
 
void split(pnode cur, pnode &lef, pnode &rig, int key){
    if(!cur){
        lef = rig = NULL;
        return;
    }
    int id = get(cur->left) + 1;
    if(id <= key){
        split(cur->right, cur->right, rig, key - id);
        lef = cur;
    }
    else{
        split(cur->left, lef, cur->left, key);
        rig = cur;
    }
    update_cnt(cur);
}
```