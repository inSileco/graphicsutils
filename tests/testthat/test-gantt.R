context("Gantt chart")

hid <- ganttChart(dfGantt)

test_that("checking areas", {
  expect_true(all(hid$completed %in% c("M", "C", "I")))
  expect_warning(ganttChart(dfGantt, order = FALSE, mstone_add = TRUE) )
  # 2 blocs of mileston
  expect_equal(sum(diff(hid$y)==-2), 1)
})
#
