#include <iostream>
#include <time.h>
#include <sys/time.h>
#include <assert.h>

/* How to use:

struct timespec start={0, 0}, end={0, 0};

clock_gettime(CLOCK_REALTIME, &start);
*program*
clock_gettime(CLOCK_REALTIME, &end);

double elapsed_select = timespec_diff(&start, &end);

*/

inline double timespec_diff(const struct timespec *start, const struct timespec *end) {
    double r = (end->tv_sec - start->tv_sec) * 1000000000;

    if (end->tv_nsec > start->tv_nsec)
        r += (end->tv_nsec - start->tv_nsec);
    else
        r -= (start->tv_nsec - end->tv_nsec);

    // return (double)(r / 1000000000);
    return r;
}

/* How to use:

struct timeval start, end;

gettimeofday(&start, NULL);
*program*
gettimeofday(&end, NULL);

double elapsed_rank = timeval_diff(&start, &end);

*/

inline double timeval_diff(const struct timeval *start, const struct timeval *end) {
    double r = (end->tv_sec - start->tv_sec) * 1000000;

    if (end->tv_usec > start->tv_usec)
        r += (end->tv_usec - start->tv_usec);
    else if (end->tv_usec < start->tv_usec)
        r -= (start->tv_usec - end->tv_usec);

    // return (double)(r / 1000000);
    return r;
}


