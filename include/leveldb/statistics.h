#include <time.h>
#include <sys/time.h>
#include <assert.h>

inline double timespec_diff(const struct timespec *start, const struct timespec *end) {
    double r = (end->tv_sec - start->tv_sec) * 1000000000;
    assert(end->tv_nsec > start->tv_nsec);
    r += (end->tv_nsec - start->tv_nsec);
    return (double)(r / 1000000000);
}
