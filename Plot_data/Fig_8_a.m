figure(1)
plot(timec,-tspringwork - min(-tspringwork),'linewidth',2)
hold on
plot(timec,-uspringwork - min(-uspringwork),'linewidth',2)
plot(timec,-dspringwork - min(-dspringwork),'linewidth',2)
legend('thorax spring energy','neg spring energy','pos spring energy');
xlabel('time (sec)');
ylabel('energy (J)');