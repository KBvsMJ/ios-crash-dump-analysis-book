# Analytic Troubleshooting

This chapter discusses a formal technique for solving problems.  The idea is to provide a framework that prompts the right questions to be asked.

There is a famous phrase cautioning us on taking an overzealous approach:

> "don't use a sledgehammer to crack a nut"

Most problems have a direct and obvious way forward to progress towards their resolution.  As engineers, developers, and testers, we are well acquainted with such problem solving.  This chapter does not concern those types of problems.

There is another less well-known phrase:

> "when you hold a hammer, everything looks like a nail"

A hammer is best for hammering in nails, and smashing things generally, but not useful for other types of task.  A hammer is a solution to a restricted set of problems.
Furthermore, our way of thinking about problems is framed to the available tools at our disposal.  If we increase the available tools, we can start thinking about problems in different ways, one of which may lead to the answers we desire.

Suppose we had a spanner and a hack saw in our toolbox.  We wanted to remove an old bathroom fitting held in place with rusty bolts.  Using the spanner might not work, due to the bolts not turning.  However, using a hack saw to remove the bolt heads might be a workable next best solution.  Observing an experienced plumber, or mechanic, reveals such tricks of the trade.

In this context we introduce "Analytic Troubleshooting".  @kepnertregoe
This will help us move forwards on problems when the obvious things have already been tried, and we are running out of ideas.

This methodology is a cut-down version of that taught by Kepner Tregoe.

## Prioritizing our problem

If we are a sole developer of an app, perhaps with a few customers, and receive a crash report, it can feel like we are being offered a curious intellectual challenge.

In a professional software engineering context, the reality is starkly different.  There is typically a team of people involved, we are some levels removed from the customer, and there are many different crash reports from different customers, for different products and product variants.

We have to prioritize which crash to work on.  We can consider three different aspects of the problem: Seriousness, Urgency and Growth.

### Prioritizing based upon impact

In many development teams, crashes are considered top-priority "P1" bugs because the customer can no longer do anything further with the app.  To judge the seriousness of the bug, we need to assess the **impact** of the bug.  What use cases were being done at the time of the problem?  If the customer is in the middle of doing an e-commerce purchase, then clearly revenue is at stake if the problem is not solved.  If the customer is updating their privacy settings and see a crash, then privacy is a problem area.  

One way to assess impact is to build analytics into our app.  Then the set of steps, and more broadly, the customer use case, can be studied alongside the crash.  Crashes from the most important use cases can then be identified as high impact bugs to fix.  One advantage of third party crash reporting services, described in a later chapter, is that they allow logs to be recorded that are delivered to the crash report server along with the crash.

Any time a life-cycle event occurs, such as foregrounding, backgrounding, appearing, disappearing, button clicks, segues, notifications, alert pop ups, and launching helper components such as the photo picker, a log message should record the action.

### Prioritizing based upon deadlines

To judge the urgency of a bug fix, we need to assess the **deadline** associated with the bug.  Whenever Apple update their product line, for example historically iPhone\index{trademark!iPhone} is updated in September, then a natural product lifecycle cadence is seen in the market.  New customers will come to the App Store to provision new apps.  There will be a lot of discussion of Apple product features in the press.  Consequently, it becomes a good market window to target.  Any crash that prevents app store approval, or app first time use is becomes more important at this time.  Occasionally, Apple introduce a new app category, for example watch apps, or sticker packs.  Being available on the first day provides a first-mover advantage, and the possibility of being featured as part of the Apple launch event.

### Prioritizing based upon trend

The growth in the number of crash reports we see can be alarming, and needs to be assessed by analysing the **trend**.  We can see how many crash reports we get over time, and see if there is a spike, or an upward trend.  

If our app crashes due to features in a new major release of iOS then the first people to experience the problem are early adopters of the beta releases of iOS.  After that, iOS devices will start being automatically upgraded.  Sometimes the new version of iOS is released in geographic staggered updates.  We would expect to see this reflected in the trend we see amongst our crash reports.  

If we see a spike (a sharp rise and then a sharp fall) in our crash reports, then there may be other factors of components of the system architecture in play.  For example, if our app relies on a back-end server which is updated in a problematic way for our app, we could see crashes until the server has been fixed.

The timing of problems can be awkward.  For example, when dealing with security credentials such as certificates, it is best to set their expiry date not during traditional vacation periods (such as Christmas or Chinese New Year) because when they expire, there might be few staff available to rectify the problem.

It is bad practice to release a major software update prior to a popular vacation period.  If our market opportunity requires the product be released for a vacation period, staffing needs to be setup to accommodate potential problems.

Keeping an eye on trends allows us to schedule work to fix problems before they become widespread amongst our customers.  Different apps have different risk profiles.  For example, a Mobile Device Management API sensitive app should be tested with Beta versions of iOS because at the systems level, subtle changes can have dramatic impact and need to be picked up early.  If we have a graphics sensitive app, then we should keep an eye on new hardware devices, hardware specification updates, and we should have a test suite that exercises the key APIs in the platform we depend upon, so a new OS version ,or hardware platform, can be quickly assessed.

The crash report trend need not be adverse.  If an unusual crash is seen only on older hardware, then we expect the trend to be downwards over time, so it might be possible to de-prioritize such crashes.

## Stating the problem

The information we have for a crash: the crash report, customer logs, analytic data etc. should be summarised into an OBJECT / DEFECT style short problem statement.  This is often a critical first step in triaging a potentially large number of crash reports.  This gives us a first level approximation of what is at hand and allows managers and other interested parties to get a feel for where we are with product quality, maturity, risks, etc.

First we state the object; that is the app or product that is failing.  Then, we state the defect; that is the symptom that is undesirable.  It should be as simple as "CameraApp Lite  crashes during when Apple Share button event used".  The problem should be tracked in a bug management system.

## Specifying the problem

Specifying the problem is the most important step in the Analytic Troubleshooting methodology because here we see the gaps in our knowledge, and that prompts the questions that lead us forwards to a resolution.

We write out a large grid with four rows and two columns as follows:

Item|IS|IS NOT
--|--|--
WHAT|Seen|Not Seen
WHERE|Seen|Not Seen
WHEN|Seen|Not Seen
EXTENT|Seen|Not Seen

Analytical Troubleshooting works well in a team setting.  Having some domain experts together with people from other disciplines and non-technical staff makes for a good troubleshooting team.  Experts sometimes overlook asking the basic questions, and less informed staff can ask good clarifying questions that further shake out implicit assumptions in the problem specification.  Hot customer problems can cause anxiety, so having the team come together to troubleshoot can ease tensions and build morale.  Sometimes our customer can be invited to participate; that can often speed up the process and shake out even more assumptions.

When troubleshooting as a team, we can just use a whiteboard divided up into a grid as above.  Each person can be given a handout that enumerates the questions to ask for each box within the grid.

On the web site associated with this book are support materials and handouts for Analytic Troubleshooting.  @icdabgithub

When troubleshooting on our own, having a print out of the questions and writing up a grid of answers is a good approach.  It seems that holding a pen gives us more creative freedom when sketching out possible causes to a problem.  It is even better to take ourselves away from our computer at this point.  We can always make notes on items to chase up. Once we have our list of items, immediately it can become clear the best way to spend our time.

We fill out details in the IS column first.  Then we fill out the IS NOT column.  Often we notice a big blank area in the grid where we have no data.  That is a signal for us to go and collect more data or do research.  The idea is to make  _relevant_ differences between the IS and IS NOT columns as small as possible.  This allows us to develop a good hypothesis that we can test, or perhaps a number of hypotheses we can prioritize for testing.

Any potential solution to the problem must entirely explain **all** the IS and IS NOT parts of the problem specification.  Often the first solution we think of only explains part of the pattern of defects seen in the problem specification.  Spending a little more time thinking about potential causes, or doing a little more research can be a good investment of time particularly if it is difficult or time-consuming to try out different candidate solutions.

### Questions to ask

- WHAT IS
  - What things have a problem?
  - What is wrong with them?
- WHAT IS NOT
  - What things could have a problem but don't?
  - What could be wrong but is not?
- WHERE IS
  - When the problem was noticed, where was it geographically?
  - Where is the problem on the thing?
- WHERE IS NOT
  - Where could the thing be when we should have seen the problem but did not?
  - Where could be problem be on the thing but isn't?
- WHEN IS
  - When was the problem first noticed?
  - When has the problem been seen again?
  - Is there any pattern in the timing?
  - When in the lifecycle of the thing was the problem first noticed?
- WHEN IS NOT
  - When could the problem have been noticed but wasn't?
  - When could it have been seen again but wasn't?
  - When else in the lifecycle of the thing could the problem be seen but wasn't?
- EXTENT IS
  - How many things have the problem?
  - What is the extent of the defect?
  - How many defects are on the thing?  
  - What is the trend?
- EXTENT IS NOT
  -  How many things could have the problem but don't?
  -  What could be the extent of the problem but isn't?
  -  How many defects could be present but aren't?
  -  What could the trend be but isn't?


### "What IS" questions

- What things have a problem?
- What is wrong with them?

Examples: Version 1.4.5 of CameraApp has the problem.  The problem is on iOS 10.1, 10.2, 10.3.  The problem is the main thread.  The function is isAllowedToShare. The Camera App crashing when the customer presses the share button.

### "What IS NOT" questions

- What things could have a problem but don't?
- What could be wrong but is not?

Examples: Version 1.4.4 of Camera App does not crash on iOS 9.3.5.  Taking a photo is not broken.

### "What IS/NOT" strategy

In our example, we don't know if version 1.4.5 of CameraApp runs on iOS 9.3.5, or if version 1.4.4 of Camera App runs on iOS 10.1, 10.2, 10.3.  Doing such experiments and then filling out the grid with more answers allows us to try and see patterns and develop a hypothesis.  Maybe sharing in iOS 10.x requires our app to data fill an Info.plist or obtain an entitlement or other artefact.

### "Where IS" questions

- When the problem was noticed, where was it geographically?
- Where is the problem on the thing?

Examples: The Apple iMac was sitting in the first floor corner office by the window.  The problems were electrical faults on the power supply, the screen, the main system board, and the memory chips.

### "Where IS NOT" questions

- Where could the thing be when we should have seen the problem but did not?
- Where could be problem be on the thing but isn't?

Examples: The same Apple iMac was fine when it was in the basement, when it was in the IT department staging area, and when it was tested at the Apple factory.  The problem could have been in software but wasn't.  The problem could have been the USB peripherals but wasn't.  The problem could have been electrical faults in the printer, desk lamp, lights or air conditioning but wasn't.  The problem could have been the laptop computer in the desk but wasn't.

### "Where IS/NOT" strategy

In the examples given we have an extensive and relevant set of IS and IS NOT answers.  Our ideas would be to move the iMac within the first floor corner office, and to different electrical outlets, and with and without power bar surge protectors would be relevant ways to tighten the IS and IS NOT answers to converge on a hypothesis.



WHEN|When was the problem first noticed?  When has the problem been seen again? Any pattern? When in the lifecycle of the thing was the problem first noticed?|When could the problem have been noticed but wasn't? When could it have been seen again but wasn't?  When else in the lifecycle of the thing could the problem be seen but wasn't?
EXTENT|How many things have the problem?  What is the extent of the defect?  How many defects are on the thing?  What is the trend?|How many things could have the problem but don't?  What could be the extent of the problem but isn't?  How many defects could be present but aren't?  What could the trend be but isn't?

At first reading, the above questions seem strangely worded.  The magic in the approach is the IS NOT column because by asking what could be there, but isn't there, reveals something about the nature of what we actually see.