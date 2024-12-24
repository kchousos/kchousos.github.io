---
title: "Intro to format string attacks"
author: ["Konstantinos Chousos"]
date: 2024-06-26
tags:
draft: true
cover: 
  image: rickroll.jpg
---
# The jesting friend

Suppose a friend is running a server somewhere, where you can `ssh` into. This *friend* has also made sure that all you can do on their server is:

1. use a text editor,
2. run python and
3. execute a peculiar `rick` binary that appears in your home directory.

The only thing this executable does is rickroll us! For example:

```
$ ./rick Konstantinos
Never gonna give you up Konstantinos
Never gonna let you down!
$
```

Being rickrolled in 2024 A.D. pushes you over the edge. You decide to take matters into your own hands and teach this friend of yours a lesson!

But..., how? This binary is owned by the root user, you cannot change its function neither delete it. To taunt you even more, your friend has also left the source code available for you to see:

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void never_gonna_let_you_down() {
    printf("Never gonna let you down!\n");
}

void never_gonna_run_around() {
    execl("/bin/sh", "sh", NULL);
}

void (*print_message)() = never_gonna_let_you_down;

int main(int argc, char ** argv) {
    if (argc != 2) {
        printf("Usage: %s <name>\n", argv[0]);
        return 1;
    }
    char buffer[strlen(argv[1]) + 1];
    strcpy(buffer, argv[1]);
    char * message = calloc(strlen(argv[1]) + 1337, sizeof(char));
    if (!message) {
        printf("Memory allocation failed\n");
        return 1;
    }
    sprintf(message, "Never gonna give you up %s!\n", argv[1]);
    printf(message);
    print_message();
    free(message);
    return 0;
}
```

The logic is easy enough to understand, but something seems off... What is the function in lines 10-12 even about? What is its purpose and what could possibly be the reason for your friend to include it there? Before you find an answer to any of those questions, a devilish thought crosses your mind: What if you *exploit* this program and use this function to become root and wreak havoc on your friend's server? *That* will teach him.

The motivation is there. Now you only need to find a way.

The only parameter that you control in this program is the input you provide. Its size is checked before doing anything memory-related, so a buffer overflow attack is out of the question. The only other instance that it is used is at the `sprintf`'s execution. "But wait, what vulnerability could this possibly have? It just *reads* a string" I hear you say. Well, let me introduce you to *format string attacks*.

# The format string

# References

{{< cite "scutExploitingFormatString2001" >}}
{{< cite "SYSTEMAPPLICATIONBINARY" >}}

{{< references >}}