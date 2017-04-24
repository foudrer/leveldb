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
    assert(end->tv_nsec > start->tv_nsec);
    r += (end->tv_nsec - start->tv_nsec);
    return (double)(r / 1000000000);
}


