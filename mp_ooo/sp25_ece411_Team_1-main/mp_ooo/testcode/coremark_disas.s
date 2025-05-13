
coremark_im.elf:     file format elf32-littleriscv


Disassembly of section .init:

aaaaa000 <_start>:
aaaaa000:	00000013          	nop
aaaaa004:	00000093          	li	ra,0
aaaaa008:	00000113          	li	sp,0
aaaaa00c:	00000193          	li	gp,0
aaaaa010:	00000213          	li	tp,0
aaaaa014:	00000293          	li	t0,0
aaaaa018:	00000313          	li	t1,0
aaaaa01c:	00000393          	li	t2,0
aaaaa020:	00000413          	li	s0,0
aaaaa024:	00000493          	li	s1,0
aaaaa028:	00000513          	li	a0,0
aaaaa02c:	00000593          	li	a1,0
aaaaa030:	00000613          	li	a2,0
aaaaa034:	00000693          	li	a3,0
aaaaa038:	00000713          	li	a4,0
aaaaa03c:	00000793          	li	a5,0
aaaaa040:	00000813          	li	a6,0
aaaaa044:	00000893          	li	a7,0
aaaaa048:	00000913          	li	s2,0
aaaaa04c:	00000993          	li	s3,0
aaaaa050:	00000a13          	li	s4,0
aaaaa054:	00000a93          	li	s5,0
aaaaa058:	00000b13          	li	s6,0
aaaaa05c:	00000b93          	li	s7,0
aaaaa060:	00000c13          	li	s8,0
aaaaa064:	00000c93          	li	s9,0
aaaaa068:	00000d13          	li	s10,0
aaaaa06c:	00000d93          	li	s11,0
aaaaa070:	00000e13          	li	t3,0
aaaaa074:	00000e93          	li	t4,0
aaaaa078:	00000f13          	li	t5,0
aaaaa07c:	00000f93          	li	t6,0

aaaaa080 <_initbss>:
aaaaa080:	00007317          	auipc	t1,0x7
aaaaa084:	f8030313          	addi	t1,t1,-128 # aaab1000 <static_memblk>
aaaaa088:	00007397          	auipc	t2,0x7
aaaaa08c:	75438393          	addi	t2,t2,1876 # aaab17dc <_bss_vma_end>
aaaaa090:	00730863          	beq	t1,t2,aaaaa0a0 <_setup>

aaaaa094 <_initbss_loop>:
aaaaa094:	00032023          	sw	zero,0(t1)
aaaaa098:	00430313          	addi	t1,t1,4
aaaaa09c:	fe736ce3          	bltu	t1,t2,aaaaa094 <_initbss_loop>

aaaaa0a0 <_setup>:
aaaaa0a0:	45556117          	auipc	sp,0x45556
aaaaa0a4:	f6010113          	addi	sp,sp,-160 # f0000000 <_stack_top>
aaaaa0a8:	00010433          	add	s0,sp,zero
aaaaa0ac:	00004097          	auipc	ra,0x4
aaaaa0b0:	d84080e7          	jalr	-636(ra) # aaaade30 <main>
aaaaa0b4:	f0002013          	slti	zero,zero,-256

aaaaa0b8 <_fini>:
aaaaa0b8:	00000063          	beqz	zero,aaaaa0b8 <_fini>
aaaaa0bc:	00000013          	nop
aaaaa0c0:	00000013          	nop
aaaaa0c4:	00000013          	nop
aaaaa0c8:	00000013          	nop
aaaaa0cc:	00000013          	nop
aaaaa0d0:	00000013          	nop
aaaaa0d4:	00000013          	nop
aaaaa0d8:	00000013          	nop
aaaaa0dc:	00000013          	nop
aaaaa0e0:	00000013          	nop
aaaaa0e4:	00000013          	nop
aaaaa0e8:	00000013          	nop
aaaaa0ec:	00000013          	nop
aaaaa0f0:	00000013          	nop
aaaaa0f4:	00000013          	nop
aaaaa0f8:	00000013          	nop
aaaaa0fc:	00000013          	nop
aaaaa100:	00000013          	nop
aaaaa104:	00000013          	nop
aaaaa108:	00000013          	nop
aaaaa10c:	00000013          	nop
aaaaa110:	00000013          	nop
aaaaa114:	00000013          	nop
aaaaa118:	00000013          	nop
aaaaa11c:	00000013          	nop
aaaaa120:	00000013          	nop
aaaaa124:	00000013          	nop
aaaaa128:	00000013          	nop
aaaaa12c:	00000013          	nop
aaaaa130:	00000013          	nop
aaaaa134:	00000013          	nop
aaaaa138:	00000013          	nop
aaaaa13c:	00000013          	nop
aaaaa140:	00000013          	nop
aaaaa144:	00000013          	nop
aaaaa148:	00000013          	nop
aaaaa14c:	00000013          	nop
aaaaa150:	00000013          	nop
aaaaa154:	00000013          	nop
aaaaa158:	00000013          	nop
aaaaa15c:	00000013          	nop
aaaaa160:	00000013          	nop
aaaaa164:	00000013          	nop
aaaaa168:	00000013          	nop
aaaaa16c:	00000013          	nop
aaaaa170:	00000013          	nop
aaaaa174:	00000013          	nop
aaaaa178:	00000013          	nop
aaaaa17c:	00000013          	nop
aaaaa180:	00000013          	nop
aaaaa184:	00000013          	nop
aaaaa188:	00000013          	nop
aaaaa18c:	00000013          	nop
aaaaa190:	00000013          	nop
aaaaa194:	00000013          	nop
aaaaa198:	00000013          	nop
aaaaa19c:	00000013          	nop
aaaaa1a0:	00000013          	nop
aaaaa1a4:	00000013          	nop
aaaaa1a8:	00000013          	nop
aaaaa1ac:	00000013          	nop
aaaaa1b0:	00000013          	nop
aaaaa1b4:	00000013          	nop
aaaaa1b8:	00000013          	nop
aaaaa1bc:	00000013          	nop
aaaaa1c0:	00000013          	nop
aaaaa1c4:	00000013          	nop
aaaaa1c8:	00000013          	nop
aaaaa1cc:	00000013          	nop
aaaaa1d0:	00000013          	nop
aaaaa1d4:	00000013          	nop
aaaaa1d8:	00000013          	nop
aaaaa1dc:	00000013          	nop
aaaaa1e0:	00000013          	nop
aaaaa1e4:	00000013          	nop
aaaaa1e8:	00000013          	nop
aaaaa1ec:	00000013          	nop
aaaaa1f0:	00000013          	nop
aaaaa1f4:	00000013          	nop
aaaaa1f8:	00000013          	nop
aaaaa1fc:	00000013          	nop
aaaaa200:	00000013          	nop
aaaaa204:	00000013          	nop
aaaaa208:	00000013          	nop
aaaaa20c:	00000013          	nop
aaaaa210:	00000013          	nop
aaaaa214:	00000013          	nop
aaaaa218:	00000013          	nop
aaaaa21c:	00000013          	nop
aaaaa220:	00000013          	nop
aaaaa224:	00000013          	nop
aaaaa228:	00000013          	nop
aaaaa22c:	00000013          	nop
aaaaa230:	00000013          	nop
aaaaa234:	00000013          	nop
aaaaa238:	00000013          	nop
aaaaa23c:	00000013          	nop
aaaaa240:	00000013          	nop
aaaaa244:	00000013          	nop
aaaaa248:	00000013          	nop
aaaaa24c:	00000013          	nop
aaaaa250:	00000013          	nop
aaaaa254:	00000013          	nop
aaaaa258:	00000013          	nop
aaaaa25c:	00000013          	nop
aaaaa260:	00000013          	nop
aaaaa264:	00000013          	nop
aaaaa268:	00000013          	nop
aaaaa26c:	00000013          	nop
aaaaa270:	00000013          	nop
aaaaa274:	00000013          	nop
aaaaa278:	00000013          	nop
aaaaa27c:	00000013          	nop
aaaaa280:	00000013          	nop
aaaaa284:	00000013          	nop
aaaaa288:	00000013          	nop
aaaaa28c:	00000013          	nop
aaaaa290:	00000013          	nop
aaaaa294:	00000013          	nop
aaaaa298:	00000013          	nop
aaaaa29c:	00000013          	nop
aaaaa2a0:	00000013          	nop
aaaaa2a4:	00000013          	nop
aaaaa2a8:	00000013          	nop
aaaaa2ac:	00000013          	nop
aaaaa2b0:	00000013          	nop
aaaaa2b4:	00000013          	nop
aaaaa2b8:	00000013          	nop
aaaaa2bc:	00000013          	nop
aaaaa2c0:	00000013          	nop
aaaaa2c4:	00000013          	nop
aaaaa2c8:	00000013          	nop
aaaaa2cc:	00000013          	nop
aaaaa2d0:	00000013          	nop
aaaaa2d4:	00000013          	nop
aaaaa2d8:	00000013          	nop
aaaaa2dc:	00000013          	nop
aaaaa2e0:	00000013          	nop
aaaaa2e4:	00000013          	nop
aaaaa2e8:	00000013          	nop
aaaaa2ec:	00000013          	nop
aaaaa2f0:	00000013          	nop
aaaaa2f4:	00000013          	nop
aaaaa2f8:	00000013          	nop
aaaaa2fc:	00000013          	nop
aaaaa300:	00000013          	nop
aaaaa304:	00000013          	nop
aaaaa308:	00000013          	nop
aaaaa30c:	00000013          	nop
aaaaa310:	00000013          	nop
aaaaa314:	00000013          	nop
aaaaa318:	00000013          	nop
aaaaa31c:	00000013          	nop
aaaaa320:	00000013          	nop
aaaaa324:	00000013          	nop
aaaaa328:	00000013          	nop
aaaaa32c:	00000013          	nop
aaaaa330:	00000013          	nop
aaaaa334:	00000013          	nop
aaaaa338:	00000013          	nop
aaaaa33c:	00000013          	nop
aaaaa340:	00000013          	nop
aaaaa344:	00000013          	nop
aaaaa348:	00000013          	nop
aaaaa34c:	00000013          	nop
aaaaa350:	00000013          	nop
aaaaa354:	00000013          	nop
aaaaa358:	00000013          	nop
aaaaa35c:	00000013          	nop
aaaaa360:	00000013          	nop
aaaaa364:	00000013          	nop
aaaaa368:	00000013          	nop
aaaaa36c:	00000013          	nop
aaaaa370:	00000013          	nop
aaaaa374:	00000013          	nop
aaaaa378:	00000013          	nop
aaaaa37c:	00000013          	nop
aaaaa380:	00000013          	nop
aaaaa384:	00000013          	nop
aaaaa388:	00000013          	nop
aaaaa38c:	00000013          	nop
aaaaa390:	00000013          	nop
aaaaa394:	00000013          	nop
aaaaa398:	00000013          	nop
aaaaa39c:	00000013          	nop
aaaaa3a0:	00000013          	nop
aaaaa3a4:	00000013          	nop
aaaaa3a8:	00000013          	nop
aaaaa3ac:	00000013          	nop
aaaaa3b0:	00000013          	nop
aaaaa3b4:	00000013          	nop
aaaaa3b8:	00000013          	nop
aaaaa3bc:	00000013          	nop
aaaaa3c0:	00000013          	nop
aaaaa3c4:	00000013          	nop
aaaaa3c8:	00000013          	nop
aaaaa3cc:	00000013          	nop
aaaaa3d0:	00000013          	nop
aaaaa3d4:	00000013          	nop
aaaaa3d8:	00000013          	nop
aaaaa3dc:	00000013          	nop
aaaaa3e0:	00000013          	nop
aaaaa3e4:	00000013          	nop
aaaaa3e8:	00000013          	nop
aaaaa3ec:	00000013          	nop
aaaaa3f0:	00000013          	nop
aaaaa3f4:	00000013          	nop
aaaaa3f8:	00000013          	nop
aaaaa3fc:	00000013          	nop
aaaaa400:	00000013          	nop
aaaaa404:	00000013          	nop
aaaaa408:	00000013          	nop
aaaaa40c:	00000013          	nop
aaaaa410:	00000013          	nop
aaaaa414:	00000013          	nop
aaaaa418:	00000013          	nop
aaaaa41c:	00000013          	nop
aaaaa420:	00000013          	nop
aaaaa424:	00000013          	nop
aaaaa428:	00000013          	nop
aaaaa42c:	00000013          	nop
aaaaa430:	00000013          	nop
aaaaa434:	00000013          	nop
aaaaa438:	00000013          	nop
aaaaa43c:	00000013          	nop
aaaaa440:	00000013          	nop
aaaaa444:	00000013          	nop
aaaaa448:	00000013          	nop
aaaaa44c:	00000013          	nop
aaaaa450:	00000013          	nop
aaaaa454:	00000013          	nop
aaaaa458:	00000013          	nop
aaaaa45c:	00000013          	nop
aaaaa460:	00000013          	nop
aaaaa464:	00000013          	nop
aaaaa468:	00000013          	nop
aaaaa46c:	00000013          	nop
aaaaa470:	00000013          	nop
aaaaa474:	00000013          	nop
aaaaa478:	00000013          	nop
aaaaa47c:	00000013          	nop
aaaaa480:	00000013          	nop
aaaaa484:	00000013          	nop
aaaaa488:	00000013          	nop
aaaaa48c:	00000013          	nop
aaaaa490:	00000013          	nop
aaaaa494:	00000013          	nop
aaaaa498:	00000013          	nop
aaaaa49c:	00000013          	nop
aaaaa4a0:	00000013          	nop
aaaaa4a4:	00000013          	nop
aaaaa4a8:	00000013          	nop
aaaaa4ac:	00000013          	nop
aaaaa4b0:	00000013          	nop
aaaaa4b4:	00000013          	nop
aaaaa4b8:	00000013          	nop
aaaaa4bc:	00000013          	nop
aaaaa4c0:	00000013          	nop
aaaaa4c4:	00000013          	nop
aaaaa4c8:	00000013          	nop
aaaaa4cc:	00000013          	nop
aaaaa4d0:	00000013          	nop
aaaaa4d4:	00000013          	nop
aaaaa4d8:	00000013          	nop
aaaaa4dc:	00000013          	nop
aaaaa4e0:	00000013          	nop
aaaaa4e4:	00000013          	nop
aaaaa4e8:	00000013          	nop
aaaaa4ec:	00000013          	nop
aaaaa4f0:	00000013          	nop
aaaaa4f4:	00000013          	nop
aaaaa4f8:	00000013          	nop
aaaaa4fc:	00000013          	nop
aaaaa500:	00000013          	nop
aaaaa504:	00000013          	nop
aaaaa508:	00000013          	nop
aaaaa50c:	00000013          	nop
aaaaa510:	00000013          	nop
aaaaa514:	00000013          	nop
aaaaa518:	00000013          	nop
aaaaa51c:	00000013          	nop
aaaaa520:	00000013          	nop
aaaaa524:	00000013          	nop
aaaaa528:	00000013          	nop
aaaaa52c:	00000013          	nop
aaaaa530:	00000013          	nop
aaaaa534:	00000013          	nop
aaaaa538:	00000013          	nop
aaaaa53c:	00000013          	nop
aaaaa540:	00000013          	nop
aaaaa544:	00000013          	nop
aaaaa548:	00000013          	nop
aaaaa54c:	00000013          	nop
aaaaa550:	00000013          	nop
aaaaa554:	00000013          	nop
aaaaa558:	00000013          	nop
aaaaa55c:	00000013          	nop
aaaaa560:	00000013          	nop
aaaaa564:	00000013          	nop
aaaaa568:	00000013          	nop
aaaaa56c:	00000013          	nop
aaaaa570:	00000013          	nop
aaaaa574:	00000013          	nop
aaaaa578:	00000013          	nop
aaaaa57c:	00000013          	nop
aaaaa580:	00000013          	nop
aaaaa584:	00000013          	nop
aaaaa588:	00000013          	nop
aaaaa58c:	00000013          	nop
aaaaa590:	00000013          	nop
aaaaa594:	00000013          	nop
aaaaa598:	00000013          	nop
aaaaa59c:	00000013          	nop
aaaaa5a0:	00000013          	nop
aaaaa5a4:	00000013          	nop
aaaaa5a8:	00000013          	nop
aaaaa5ac:	00000013          	nop
aaaaa5b0:	00000013          	nop
aaaaa5b4:	00000013          	nop
aaaaa5b8:	00000013          	nop
aaaaa5bc:	00000013          	nop
aaaaa5c0:	00000013          	nop
aaaaa5c4:	00000013          	nop
aaaaa5c8:	00000013          	nop
aaaaa5cc:	00000013          	nop
aaaaa5d0:	00000013          	nop
aaaaa5d4:	00000013          	nop
aaaaa5d8:	00000013          	nop
aaaaa5dc:	00000013          	nop
aaaaa5e0:	00000013          	nop
aaaaa5e4:	00000013          	nop
aaaaa5e8:	00000013          	nop
aaaaa5ec:	00000013          	nop
aaaaa5f0:	00000013          	nop
aaaaa5f4:	00000013          	nop
aaaaa5f8:	00000013          	nop
aaaaa5fc:	00000013          	nop
aaaaa600:	00000013          	nop
aaaaa604:	00000013          	nop
aaaaa608:	00000013          	nop
aaaaa60c:	00000013          	nop
aaaaa610:	00000013          	nop
aaaaa614:	00000013          	nop
aaaaa618:	00000013          	nop
aaaaa61c:	00000013          	nop
aaaaa620:	00000013          	nop
aaaaa624:	00000013          	nop
aaaaa628:	00000013          	nop
aaaaa62c:	00000013          	nop
aaaaa630:	00000013          	nop
aaaaa634:	00000013          	nop
aaaaa638:	00000013          	nop
aaaaa63c:	00000013          	nop
aaaaa640:	00000013          	nop
aaaaa644:	00000013          	nop
aaaaa648:	00000013          	nop
aaaaa64c:	00000013          	nop
aaaaa650:	00000013          	nop
aaaaa654:	00000013          	nop
aaaaa658:	00000013          	nop
aaaaa65c:	00000013          	nop
aaaaa660:	00000013          	nop
aaaaa664:	00000013          	nop
aaaaa668:	00000013          	nop
aaaaa66c:	00000013          	nop
aaaaa670:	00000013          	nop
aaaaa674:	00000013          	nop
aaaaa678:	00000013          	nop
aaaaa67c:	00000013          	nop
aaaaa680:	00000013          	nop
aaaaa684:	00000013          	nop
aaaaa688:	00000013          	nop
aaaaa68c:	00000013          	nop
aaaaa690:	00000013          	nop
aaaaa694:	00000013          	nop
aaaaa698:	00000013          	nop
aaaaa69c:	00000013          	nop
aaaaa6a0:	00000013          	nop
aaaaa6a4:	00000013          	nop
aaaaa6a8:	00000013          	nop
aaaaa6ac:	00000013          	nop
aaaaa6b0:	00000013          	nop
aaaaa6b4:	00000013          	nop
aaaaa6b8:	00000013          	nop
aaaaa6bc:	00000013          	nop
aaaaa6c0:	00000013          	nop
aaaaa6c4:	00000013          	nop
aaaaa6c8:	00000013          	nop
aaaaa6cc:	00000013          	nop
aaaaa6d0:	00000013          	nop
aaaaa6d4:	00000013          	nop
aaaaa6d8:	00000013          	nop
aaaaa6dc:	00000013          	nop
aaaaa6e0:	00000013          	nop
aaaaa6e4:	00000013          	nop
aaaaa6e8:	00000013          	nop
aaaaa6ec:	00000013          	nop
aaaaa6f0:	00000013          	nop
aaaaa6f4:	00000013          	nop
aaaaa6f8:	00000013          	nop
aaaaa6fc:	00000013          	nop
aaaaa700:	00000013          	nop
aaaaa704:	00000013          	nop
aaaaa708:	00000013          	nop
aaaaa70c:	00000013          	nop
aaaaa710:	00000013          	nop
aaaaa714:	00000013          	nop
aaaaa718:	00000013          	nop
aaaaa71c:	00000013          	nop
aaaaa720:	00000013          	nop
aaaaa724:	00000013          	nop
aaaaa728:	00000013          	nop
aaaaa72c:	00000013          	nop
aaaaa730:	00000013          	nop
aaaaa734:	00000013          	nop
aaaaa738:	00000013          	nop
aaaaa73c:	00000013          	nop
aaaaa740:	00000013          	nop
aaaaa744:	00000013          	nop
aaaaa748:	00000013          	nop
aaaaa74c:	00000013          	nop
aaaaa750:	00000013          	nop
aaaaa754:	00000013          	nop
aaaaa758:	00000013          	nop
aaaaa75c:	00000013          	nop
aaaaa760:	00000013          	nop
aaaaa764:	00000013          	nop
aaaaa768:	00000013          	nop
aaaaa76c:	00000013          	nop
aaaaa770:	00000013          	nop
aaaaa774:	00000013          	nop
aaaaa778:	00000013          	nop
aaaaa77c:	00000013          	nop
aaaaa780:	00000013          	nop
aaaaa784:	00000013          	nop
aaaaa788:	00000013          	nop
aaaaa78c:	00000013          	nop
aaaaa790:	00000013          	nop
aaaaa794:	00000013          	nop
aaaaa798:	00000013          	nop
aaaaa79c:	00000013          	nop
aaaaa7a0:	00000013          	nop
aaaaa7a4:	00000013          	nop
aaaaa7a8:	00000013          	nop
aaaaa7ac:	00000013          	nop
aaaaa7b0:	00000013          	nop
aaaaa7b4:	00000013          	nop
aaaaa7b8:	00000013          	nop
aaaaa7bc:	00000013          	nop
aaaaa7c0:	00000013          	nop
aaaaa7c4:	00000013          	nop
aaaaa7c8:	00000013          	nop
aaaaa7cc:	00000013          	nop
aaaaa7d0:	00000013          	nop
aaaaa7d4:	00000013          	nop
aaaaa7d8:	00000013          	nop
aaaaa7dc:	00000013          	nop
aaaaa7e0:	00000013          	nop
aaaaa7e4:	00000013          	nop
aaaaa7e8:	00000013          	nop
aaaaa7ec:	00000013          	nop
aaaaa7f0:	00000013          	nop
aaaaa7f4:	00000013          	nop
aaaaa7f8:	00000013          	nop
aaaaa7fc:	00000013          	nop
aaaaa800:	00000013          	nop
aaaaa804:	00000013          	nop
aaaaa808:	00000013          	nop
aaaaa80c:	00000013          	nop
aaaaa810:	00000013          	nop
aaaaa814:	00000013          	nop
aaaaa818:	00000013          	nop
aaaaa81c:	00000013          	nop
aaaaa820:	00000013          	nop
aaaaa824:	00000013          	nop
aaaaa828:	00000013          	nop
aaaaa82c:	00000013          	nop
aaaaa830:	00000013          	nop
aaaaa834:	00000013          	nop
aaaaa838:	00000013          	nop
aaaaa83c:	00000013          	nop
aaaaa840:	00000013          	nop
aaaaa844:	00000013          	nop
aaaaa848:	00000013          	nop
aaaaa84c:	00000013          	nop
aaaaa850:	00000013          	nop
aaaaa854:	00000013          	nop
aaaaa858:	00000013          	nop
aaaaa85c:	00000013          	nop
aaaaa860:	00000013          	nop
aaaaa864:	00000013          	nop
aaaaa868:	00000013          	nop
aaaaa86c:	00000013          	nop
aaaaa870:	00000013          	nop
aaaaa874:	00000013          	nop
aaaaa878:	00000013          	nop
aaaaa87c:	00000013          	nop
aaaaa880:	00000013          	nop
aaaaa884:	00000013          	nop
aaaaa888:	00000013          	nop
aaaaa88c:	00000013          	nop
aaaaa890:	00000013          	nop
aaaaa894:	00000013          	nop
aaaaa898:	00000013          	nop
aaaaa89c:	00000013          	nop
aaaaa8a0:	00000013          	nop
aaaaa8a4:	00000013          	nop
aaaaa8a8:	00000013          	nop
aaaaa8ac:	00000013          	nop
aaaaa8b0:	00000013          	nop
aaaaa8b4:	00000013          	nop
aaaaa8b8:	00000013          	nop
aaaaa8bc:	00000013          	nop
aaaaa8c0:	00000013          	nop
aaaaa8c4:	00000013          	nop
aaaaa8c8:	00000013          	nop
aaaaa8cc:	00000013          	nop
aaaaa8d0:	00000013          	nop
aaaaa8d4:	00000013          	nop
aaaaa8d8:	00000013          	nop
aaaaa8dc:	00000013          	nop
aaaaa8e0:	00000013          	nop
aaaaa8e4:	00000013          	nop
aaaaa8e8:	00000013          	nop
aaaaa8ec:	00000013          	nop
aaaaa8f0:	00000013          	nop
aaaaa8f4:	00000013          	nop
aaaaa8f8:	00000013          	nop
aaaaa8fc:	00000013          	nop
aaaaa900:	00000013          	nop
aaaaa904:	00000013          	nop
aaaaa908:	00000013          	nop
aaaaa90c:	00000013          	nop
aaaaa910:	00000013          	nop
aaaaa914:	00000013          	nop
aaaaa918:	00000013          	nop
aaaaa91c:	00000013          	nop
aaaaa920:	00000013          	nop
aaaaa924:	00000013          	nop
aaaaa928:	00000013          	nop
aaaaa92c:	00000013          	nop
aaaaa930:	00000013          	nop
aaaaa934:	00000013          	nop
aaaaa938:	00000013          	nop
aaaaa93c:	00000013          	nop
aaaaa940:	00000013          	nop
aaaaa944:	00000013          	nop
aaaaa948:	00000013          	nop
aaaaa94c:	00000013          	nop
aaaaa950:	00000013          	nop
aaaaa954:	00000013          	nop
aaaaa958:	00000013          	nop
aaaaa95c:	00000013          	nop
aaaaa960:	00000013          	nop
aaaaa964:	00000013          	nop
aaaaa968:	00000013          	nop
aaaaa96c:	00000013          	nop
aaaaa970:	00000013          	nop
aaaaa974:	00000013          	nop
aaaaa978:	00000013          	nop
aaaaa97c:	00000013          	nop
aaaaa980:	00000013          	nop
aaaaa984:	00000013          	nop
aaaaa988:	00000013          	nop
aaaaa98c:	00000013          	nop
aaaaa990:	00000013          	nop
aaaaa994:	00000013          	nop
aaaaa998:	00000013          	nop
aaaaa99c:	00000013          	nop
aaaaa9a0:	00000013          	nop
aaaaa9a4:	00000013          	nop
aaaaa9a8:	00000013          	nop
aaaaa9ac:	00000013          	nop
aaaaa9b0:	00000013          	nop
aaaaa9b4:	00000013          	nop
aaaaa9b8:	00000013          	nop
aaaaa9bc:	00000013          	nop
aaaaa9c0:	00000013          	nop
aaaaa9c4:	00000013          	nop
aaaaa9c8:	00000013          	nop
aaaaa9cc:	00000013          	nop
aaaaa9d0:	00000013          	nop
aaaaa9d4:	00000013          	nop
aaaaa9d8:	00000013          	nop
aaaaa9dc:	00000013          	nop
aaaaa9e0:	00000013          	nop
aaaaa9e4:	00000013          	nop
aaaaa9e8:	00000013          	nop
aaaaa9ec:	00000013          	nop
aaaaa9f0:	00000013          	nop
aaaaa9f4:	00000013          	nop
aaaaa9f8:	00000013          	nop
aaaaa9fc:	00000013          	nop
aaaaaa00:	00000013          	nop
aaaaaa04:	00000013          	nop
aaaaaa08:	00000013          	nop
aaaaaa0c:	00000013          	nop
aaaaaa10:	00000013          	nop
aaaaaa14:	00000013          	nop
aaaaaa18:	00000013          	nop
aaaaaa1c:	00000013          	nop
aaaaaa20:	00000013          	nop
aaaaaa24:	00000013          	nop
aaaaaa28:	00000013          	nop
aaaaaa2c:	00000013          	nop
aaaaaa30:	00000013          	nop
aaaaaa34:	00000013          	nop
aaaaaa38:	00000013          	nop
aaaaaa3c:	00000013          	nop
aaaaaa40:	00000013          	nop
aaaaaa44:	00000013          	nop
aaaaaa48:	00000013          	nop
aaaaaa4c:	00000013          	nop
aaaaaa50:	00000013          	nop
aaaaaa54:	00000013          	nop
aaaaaa58:	00000013          	nop
aaaaaa5c:	00000013          	nop
aaaaaa60:	00000013          	nop
aaaaaa64:	00000013          	nop
aaaaaa68:	00000013          	nop
aaaaaa6c:	00000013          	nop
aaaaaa70:	00000013          	nop
aaaaaa74:	00000013          	nop
aaaaaa78:	00000013          	nop
aaaaaa7c:	00000013          	nop
aaaaaa80:	00000013          	nop
aaaaaa84:	00000013          	nop
aaaaaa88:	00000013          	nop
aaaaaa8c:	00000013          	nop
aaaaaa90:	00000013          	nop
aaaaaa94:	00000013          	nop
aaaaaa98:	00000013          	nop
aaaaaa9c:	00000013          	nop
aaaaaaa0:	00000013          	nop
aaaaaaa4:	00000013          	nop
aaaaaaa8:	00000013          	nop
aaaaaaac:	00000013          	nop
aaaaaab0:	00000013          	nop
aaaaaab4:	00000013          	nop
aaaaaab8:	00000013          	nop
aaaaaabc:	00000013          	nop
aaaaaac0:	00000013          	nop
aaaaaac4:	00000013          	nop
aaaaaac8:	00000013          	nop
aaaaaacc:	00000013          	nop
aaaaaad0:	00000013          	nop
aaaaaad4:	00000013          	nop
aaaaaad8:	00000013          	nop
aaaaaadc:	00000013          	nop
aaaaaae0:	00000013          	nop
aaaaaae4:	00000013          	nop
aaaaaae8:	00000013          	nop
aaaaaaec:	00000013          	nop
aaaaaaf0:	00000013          	nop
aaaaaaf4:	00000013          	nop
aaaaaaf8:	00000013          	nop
aaaaaafc:	00000013          	nop
aaaaab00:	00000013          	nop
aaaaab04:	00000013          	nop
aaaaab08:	00000013          	nop
aaaaab0c:	00000013          	nop
aaaaab10:	00000013          	nop
aaaaab14:	00000013          	nop
aaaaab18:	00000013          	nop
aaaaab1c:	00000013          	nop
aaaaab20:	00000013          	nop
aaaaab24:	00000013          	nop
aaaaab28:	00000013          	nop
aaaaab2c:	00000013          	nop
aaaaab30:	00000013          	nop
aaaaab34:	00000013          	nop
aaaaab38:	00000013          	nop
aaaaab3c:	00000013          	nop
aaaaab40:	00000013          	nop
aaaaab44:	00000013          	nop
aaaaab48:	00000013          	nop
aaaaab4c:	00000013          	nop
aaaaab50:	00000013          	nop
aaaaab54:	00000013          	nop
aaaaab58:	00000013          	nop
aaaaab5c:	00000013          	nop
aaaaab60:	00000013          	nop
aaaaab64:	00000013          	nop
aaaaab68:	00000013          	nop
aaaaab6c:	00000013          	nop
aaaaab70:	00000013          	nop
aaaaab74:	00000013          	nop
aaaaab78:	00000013          	nop
aaaaab7c:	00000013          	nop
aaaaab80:	00000013          	nop
aaaaab84:	00000013          	nop
aaaaab88:	00000013          	nop
aaaaab8c:	00000013          	nop
aaaaab90:	00000013          	nop
aaaaab94:	00000013          	nop
aaaaab98:	00000013          	nop
aaaaab9c:	00000013          	nop
aaaaaba0:	00000013          	nop
aaaaaba4:	00000013          	nop
aaaaaba8:	00000013          	nop
aaaaabac:	00000013          	nop
aaaaabb0:	00000013          	nop
aaaaabb4:	00000013          	nop
aaaaabb8:	00000013          	nop
aaaaabbc:	00000013          	nop
aaaaabc0:	00000013          	nop
aaaaabc4:	00000013          	nop
aaaaabc8:	00000013          	nop
aaaaabcc:	00000013          	nop
aaaaabd0:	00000013          	nop
aaaaabd4:	00000013          	nop
aaaaabd8:	00000013          	nop
aaaaabdc:	00000013          	nop
aaaaabe0:	00000013          	nop
aaaaabe4:	00000013          	nop
aaaaabe8:	00000013          	nop
aaaaabec:	00000013          	nop
aaaaabf0:	00000013          	nop
aaaaabf4:	00000013          	nop
aaaaabf8:	00000013          	nop
aaaaabfc:	00000013          	nop
aaaaac00:	00000013          	nop
aaaaac04:	00000013          	nop
aaaaac08:	00000013          	nop
aaaaac0c:	00000013          	nop
aaaaac10:	00000013          	nop
aaaaac14:	00000013          	nop
aaaaac18:	00000013          	nop
aaaaac1c:	00000013          	nop
aaaaac20:	00000013          	nop
aaaaac24:	00000013          	nop
aaaaac28:	00000013          	nop
aaaaac2c:	00000013          	nop
aaaaac30:	00000013          	nop
aaaaac34:	00000013          	nop
aaaaac38:	00000013          	nop
aaaaac3c:	00000013          	nop
aaaaac40:	00000013          	nop
aaaaac44:	00000013          	nop
aaaaac48:	00000013          	nop
aaaaac4c:	00000013          	nop
aaaaac50:	00000013          	nop
aaaaac54:	00000013          	nop
aaaaac58:	00000013          	nop
aaaaac5c:	00000013          	nop
aaaaac60:	00000013          	nop
aaaaac64:	00000013          	nop
aaaaac68:	00000013          	nop
aaaaac6c:	00000013          	nop
aaaaac70:	00000013          	nop
aaaaac74:	00000013          	nop
aaaaac78:	00000013          	nop
aaaaac7c:	00000013          	nop
aaaaac80:	00000013          	nop
aaaaac84:	00000013          	nop
aaaaac88:	00000013          	nop
aaaaac8c:	00000013          	nop
aaaaac90:	00000013          	nop
aaaaac94:	00000013          	nop
aaaaac98:	00000013          	nop
aaaaac9c:	00000013          	nop
aaaaaca0:	00000013          	nop
aaaaaca4:	00000013          	nop
aaaaaca8:	00000013          	nop
aaaaacac:	00000013          	nop
aaaaacb0:	00000013          	nop
aaaaacb4:	00000013          	nop
aaaaacb8:	00000013          	nop
aaaaacbc:	00000013          	nop
aaaaacc0:	00000013          	nop
aaaaacc4:	00000013          	nop
aaaaacc8:	00000013          	nop
aaaaaccc:	00000013          	nop
aaaaacd0:	00000013          	nop
aaaaacd4:	00000013          	nop
aaaaacd8:	00000013          	nop
aaaaacdc:	00000013          	nop
aaaaace0:	00000013          	nop
aaaaace4:	00000013          	nop
aaaaace8:	00000013          	nop
aaaaacec:	00000013          	nop
aaaaacf0:	00000013          	nop
aaaaacf4:	00000013          	nop
aaaaacf8:	00000013          	nop
aaaaacfc:	00000013          	nop
aaaaad00:	00000013          	nop
aaaaad04:	00000013          	nop
aaaaad08:	00000013          	nop
aaaaad0c:	00000013          	nop
aaaaad10:	00000013          	nop
aaaaad14:	00000013          	nop
aaaaad18:	00000013          	nop
aaaaad1c:	00000013          	nop
aaaaad20:	00000013          	nop
aaaaad24:	00000013          	nop
aaaaad28:	00000013          	nop
aaaaad2c:	00000013          	nop
aaaaad30:	00000013          	nop
aaaaad34:	00000013          	nop
aaaaad38:	00000013          	nop
aaaaad3c:	00000013          	nop
aaaaad40:	00000013          	nop
aaaaad44:	00000013          	nop
aaaaad48:	00000013          	nop
aaaaad4c:	00000013          	nop
aaaaad50:	00000013          	nop
aaaaad54:	00000013          	nop
aaaaad58:	00000013          	nop
aaaaad5c:	00000013          	nop
aaaaad60:	00000013          	nop
aaaaad64:	00000013          	nop
aaaaad68:	00000013          	nop
aaaaad6c:	00000013          	nop
aaaaad70:	00000013          	nop
aaaaad74:	00000013          	nop
aaaaad78:	00000013          	nop
aaaaad7c:	00000013          	nop
aaaaad80:	00000013          	nop
aaaaad84:	00000013          	nop
aaaaad88:	00000013          	nop
aaaaad8c:	00000013          	nop
aaaaad90:	00000013          	nop
aaaaad94:	00000013          	nop
aaaaad98:	00000013          	nop
aaaaad9c:	00000013          	nop
aaaaada0:	00000013          	nop
aaaaada4:	00000013          	nop
aaaaada8:	00000013          	nop
aaaaadac:	00000013          	nop
aaaaadb0:	00000013          	nop
aaaaadb4:	00000013          	nop
aaaaadb8:	00000013          	nop
aaaaadbc:	00000013          	nop
aaaaadc0:	00000013          	nop
aaaaadc4:	00000013          	nop
aaaaadc8:	00000013          	nop
aaaaadcc:	00000013          	nop
aaaaadd0:	00000013          	nop
aaaaadd4:	00000013          	nop
aaaaadd8:	00000013          	nop
aaaaaddc:	00000013          	nop
aaaaade0:	00000013          	nop
aaaaade4:	00000013          	nop
aaaaade8:	00000013          	nop
aaaaadec:	00000013          	nop
aaaaadf0:	00000013          	nop
aaaaadf4:	00000013          	nop
aaaaadf8:	00000013          	nop
aaaaadfc:	00000013          	nop
aaaaae00:	00000013          	nop
aaaaae04:	00000013          	nop
aaaaae08:	00000013          	nop
aaaaae0c:	00000013          	nop
aaaaae10:	00000013          	nop
aaaaae14:	00000013          	nop
aaaaae18:	00000013          	nop
aaaaae1c:	00000013          	nop
aaaaae20:	00000013          	nop
aaaaae24:	00000013          	nop
aaaaae28:	00000013          	nop
aaaaae2c:	00000013          	nop
aaaaae30:	00000013          	nop
aaaaae34:	00000013          	nop
aaaaae38:	00000013          	nop
aaaaae3c:	00000013          	nop
aaaaae40:	00000013          	nop
aaaaae44:	00000013          	nop
aaaaae48:	00000013          	nop
aaaaae4c:	00000013          	nop
aaaaae50:	00000013          	nop
aaaaae54:	00000013          	nop
aaaaae58:	00000013          	nop
aaaaae5c:	00000013          	nop
aaaaae60:	00000013          	nop
aaaaae64:	00000013          	nop
aaaaae68:	00000013          	nop
aaaaae6c:	00000013          	nop
aaaaae70:	00000013          	nop
aaaaae74:	00000013          	nop
aaaaae78:	00000013          	nop
aaaaae7c:	00000013          	nop
aaaaae80:	00000013          	nop
aaaaae84:	00000013          	nop
aaaaae88:	00000013          	nop
aaaaae8c:	00000013          	nop
aaaaae90:	00000013          	nop
aaaaae94:	00000013          	nop
aaaaae98:	00000013          	nop
aaaaae9c:	00000013          	nop
aaaaaea0:	00000013          	nop
aaaaaea4:	00000013          	nop
aaaaaea8:	00000013          	nop
aaaaaeac:	00000013          	nop
aaaaaeb0:	00000013          	nop
aaaaaeb4:	00000013          	nop
aaaaaeb8:	00000013          	nop
aaaaaebc:	00000013          	nop
aaaaaec0:	00000013          	nop
aaaaaec4:	00000013          	nop
aaaaaec8:	00000013          	nop
aaaaaecc:	00000013          	nop
aaaaaed0:	00000013          	nop
aaaaaed4:	00000013          	nop
aaaaaed8:	00000013          	nop
aaaaaedc:	00000013          	nop
aaaaaee0:	00000013          	nop
aaaaaee4:	00000013          	nop
aaaaaee8:	00000013          	nop
aaaaaeec:	00000013          	nop
aaaaaef0:	00000013          	nop
aaaaaef4:	00000013          	nop
aaaaaef8:	00000013          	nop
aaaaaefc:	00000013          	nop
aaaaaf00:	00000013          	nop
aaaaaf04:	00000013          	nop
aaaaaf08:	00000013          	nop
aaaaaf0c:	00000013          	nop
aaaaaf10:	00000013          	nop
aaaaaf14:	00000013          	nop
aaaaaf18:	00000013          	nop
aaaaaf1c:	00000013          	nop
aaaaaf20:	00000013          	nop
aaaaaf24:	00000013          	nop
aaaaaf28:	00000013          	nop
aaaaaf2c:	00000013          	nop
aaaaaf30:	00000013          	nop
aaaaaf34:	00000013          	nop
aaaaaf38:	00000013          	nop
aaaaaf3c:	00000013          	nop
aaaaaf40:	00000013          	nop
aaaaaf44:	00000013          	nop
aaaaaf48:	00000013          	nop
aaaaaf4c:	00000013          	nop
aaaaaf50:	00000013          	nop
aaaaaf54:	00000013          	nop
aaaaaf58:	00000013          	nop
aaaaaf5c:	00000013          	nop
aaaaaf60:	00000013          	nop
aaaaaf64:	00000013          	nop
aaaaaf68:	00000013          	nop
aaaaaf6c:	00000013          	nop
aaaaaf70:	00000013          	nop
aaaaaf74:	00000013          	nop
aaaaaf78:	00000013          	nop
aaaaaf7c:	00000013          	nop
aaaaaf80:	00000013          	nop
aaaaaf84:	00000013          	nop
aaaaaf88:	00000013          	nop
aaaaaf8c:	00000013          	nop
aaaaaf90:	00000013          	nop
aaaaaf94:	00000013          	nop
aaaaaf98:	00000013          	nop
aaaaaf9c:	00000013          	nop
aaaaafa0:	00000013          	nop
aaaaafa4:	00000013          	nop
aaaaafa8:	00000013          	nop
aaaaafac:	00000013          	nop
aaaaafb0:	00000013          	nop
aaaaafb4:	00000013          	nop
aaaaafb8:	00000013          	nop
aaaaafbc:	00000013          	nop
aaaaafc0:	00000013          	nop
aaaaafc4:	00000013          	nop
aaaaafc8:	00000013          	nop
aaaaafcc:	00000013          	nop
aaaaafd0:	00000013          	nop
aaaaafd4:	00000013          	nop
aaaaafd8:	00000013          	nop
aaaaafdc:	00000013          	nop
aaaaafe0:	00000013          	nop
aaaaafe4:	00000013          	nop
aaaaafe8:	00000013          	nop
aaaaafec:	00000013          	nop
aaaaaff0:	00000013          	nop
aaaaaff4:	00000013          	nop
aaaaaff8:	00000013          	nop
aaaaaffc:	00000013          	nop

Disassembly of section .text:

aaaab000 <crcu16>:
aaaab000:	0ff57313          	zext.b	t1,a0
aaaab004:	00b346b3          	xor	a3,t1,a1
aaaab008:	0016f693          	andi	a3,a3,1
aaaab00c:	ffffa737          	lui	a4,0xffffa
aaaab010:	00170713          	addi	a4,a4,1 # ffffa001 <_stack_top+0xfffa001>
aaaab014:	40d006b3          	neg	a3,a3
aaaab018:	0015d593          	srli	a1,a1,0x1
aaaab01c:	00e6f6b3          	and	a3,a3,a4
aaaab020:	00b6c6b3          	xor	a3,a3,a1
aaaab024:	01069693          	slli	a3,a3,0x10
aaaab028:	0106d693          	srli	a3,a3,0x10
aaaab02c:	00135793          	srli	a5,t1,0x1
aaaab030:	00d7c7b3          	xor	a5,a5,a3
aaaab034:	0017f793          	andi	a5,a5,1
aaaab038:	40f007b3          	neg	a5,a5
aaaab03c:	00e7f7b3          	and	a5,a5,a4
aaaab040:	0016d693          	srli	a3,a3,0x1
aaaab044:	00d7c7b3          	xor	a5,a5,a3
aaaab048:	01079793          	slli	a5,a5,0x10
aaaab04c:	00235813          	srli	a6,t1,0x2
aaaab050:	0107d793          	srli	a5,a5,0x10
aaaab054:	00f84833          	xor	a6,a6,a5
aaaab058:	00187813          	andi	a6,a6,1
aaaab05c:	41000833          	neg	a6,a6
aaaab060:	00e87833          	and	a6,a6,a4
aaaab064:	0017d793          	srli	a5,a5,0x1
aaaab068:	00f84833          	xor	a6,a6,a5
aaaab06c:	01081813          	slli	a6,a6,0x10
aaaab070:	00335593          	srli	a1,t1,0x3
aaaab074:	01085813          	srli	a6,a6,0x10
aaaab078:	0105c5b3          	xor	a1,a1,a6
aaaab07c:	0015f593          	andi	a1,a1,1
aaaab080:	40b005b3          	neg	a1,a1
aaaab084:	00e5f5b3          	and	a1,a1,a4
aaaab088:	00185813          	srli	a6,a6,0x1
aaaab08c:	0105c5b3          	xor	a1,a1,a6
aaaab090:	01059593          	slli	a1,a1,0x10
aaaab094:	00435613          	srli	a2,t1,0x4
aaaab098:	0105d593          	srli	a1,a1,0x10
aaaab09c:	00b64633          	xor	a2,a2,a1
aaaab0a0:	00167613          	andi	a2,a2,1
aaaab0a4:	40c00633          	neg	a2,a2
aaaab0a8:	00e67633          	and	a2,a2,a4
aaaab0ac:	0015d593          	srli	a1,a1,0x1
aaaab0b0:	00b64633          	xor	a2,a2,a1
aaaab0b4:	01061613          	slli	a2,a2,0x10
aaaab0b8:	00535693          	srli	a3,t1,0x5
aaaab0bc:	01065613          	srli	a2,a2,0x10
aaaab0c0:	00c6c6b3          	xor	a3,a3,a2
aaaab0c4:	0016f693          	andi	a3,a3,1
aaaab0c8:	40d006b3          	neg	a3,a3
aaaab0cc:	00e6f6b3          	and	a3,a3,a4
aaaab0d0:	00165613          	srli	a2,a2,0x1
aaaab0d4:	00c6c6b3          	xor	a3,a3,a2
aaaab0d8:	01069693          	slli	a3,a3,0x10
aaaab0dc:	00635793          	srli	a5,t1,0x6
aaaab0e0:	0106d693          	srli	a3,a3,0x10
aaaab0e4:	00d7c7b3          	xor	a5,a5,a3
aaaab0e8:	0017f793          	andi	a5,a5,1
aaaab0ec:	40f007b3          	neg	a5,a5
aaaab0f0:	00e7f7b3          	and	a5,a5,a4
aaaab0f4:	0016d693          	srli	a3,a3,0x1
aaaab0f8:	00d7c7b3          	xor	a5,a5,a3
aaaab0fc:	01079793          	slli	a5,a5,0x10
aaaab100:	0107d793          	srli	a5,a5,0x10
aaaab104:	00735313          	srli	t1,t1,0x7
aaaab108:	00f34333          	xor	t1,t1,a5
aaaab10c:	00137313          	andi	t1,t1,1
aaaab110:	40600333          	neg	t1,t1
aaaab114:	00e37333          	and	t1,t1,a4
aaaab118:	0017d793          	srli	a5,a5,0x1
aaaab11c:	00f34333          	xor	t1,t1,a5
aaaab120:	01031313          	slli	t1,t1,0x10
aaaab124:	00855513          	srli	a0,a0,0x8
aaaab128:	01035313          	srli	t1,t1,0x10
aaaab12c:	006547b3          	xor	a5,a0,t1
aaaab130:	0017f793          	andi	a5,a5,1
aaaab134:	40f007b3          	neg	a5,a5
aaaab138:	00e7f7b3          	and	a5,a5,a4
aaaab13c:	00135313          	srli	t1,t1,0x1
aaaab140:	0067c7b3          	xor	a5,a5,t1
aaaab144:	01079793          	slli	a5,a5,0x10
aaaab148:	00155e93          	srli	t4,a0,0x1
aaaab14c:	0107d793          	srli	a5,a5,0x10
aaaab150:	00255e13          	srli	t3,a0,0x2
aaaab154:	00355893          	srli	a7,a0,0x3
aaaab158:	00455813          	srli	a6,a0,0x4
aaaab15c:	00655693          	srli	a3,a0,0x6
aaaab160:	00755593          	srli	a1,a0,0x7
aaaab164:	00555613          	srli	a2,a0,0x5
aaaab168:	00fec533          	xor	a0,t4,a5
aaaab16c:	00157513          	andi	a0,a0,1
aaaab170:	40a00533          	neg	a0,a0
aaaab174:	00e57533          	and	a0,a0,a4
aaaab178:	0017d793          	srli	a5,a5,0x1
aaaab17c:	00f54533          	xor	a0,a0,a5
aaaab180:	01051513          	slli	a0,a0,0x10
aaaab184:	01055513          	srli	a0,a0,0x10
aaaab188:	00ae47b3          	xor	a5,t3,a0
aaaab18c:	0017f793          	andi	a5,a5,1
aaaab190:	40f007b3          	neg	a5,a5
aaaab194:	00e7f7b3          	and	a5,a5,a4
aaaab198:	00155513          	srli	a0,a0,0x1
aaaab19c:	00a7c7b3          	xor	a5,a5,a0
aaaab1a0:	01079793          	slli	a5,a5,0x10
aaaab1a4:	0107d793          	srli	a5,a5,0x10
aaaab1a8:	00f8c533          	xor	a0,a7,a5
aaaab1ac:	00157513          	andi	a0,a0,1
aaaab1b0:	40a00533          	neg	a0,a0
aaaab1b4:	00e57533          	and	a0,a0,a4
aaaab1b8:	0017d793          	srli	a5,a5,0x1
aaaab1bc:	00f54533          	xor	a0,a0,a5
aaaab1c0:	01051513          	slli	a0,a0,0x10
aaaab1c4:	01055513          	srli	a0,a0,0x10
aaaab1c8:	00a847b3          	xor	a5,a6,a0
aaaab1cc:	0017f793          	andi	a5,a5,1
aaaab1d0:	40f007b3          	neg	a5,a5
aaaab1d4:	00e7f7b3          	and	a5,a5,a4
aaaab1d8:	00155513          	srli	a0,a0,0x1
aaaab1dc:	00a7c7b3          	xor	a5,a5,a0
aaaab1e0:	01079793          	slli	a5,a5,0x10
aaaab1e4:	0107d793          	srli	a5,a5,0x10
aaaab1e8:	00f64633          	xor	a2,a2,a5
aaaab1ec:	00167613          	andi	a2,a2,1
aaaab1f0:	40c00633          	neg	a2,a2
aaaab1f4:	00e67633          	and	a2,a2,a4
aaaab1f8:	0017d793          	srli	a5,a5,0x1
aaaab1fc:	00f64633          	xor	a2,a2,a5
aaaab200:	01061613          	slli	a2,a2,0x10
aaaab204:	01065613          	srli	a2,a2,0x10
aaaab208:	00c6c7b3          	xor	a5,a3,a2
aaaab20c:	0017f793          	andi	a5,a5,1
aaaab210:	40f007b3          	neg	a5,a5
aaaab214:	00e7f7b3          	and	a5,a5,a4
aaaab218:	00165613          	srli	a2,a2,0x1
aaaab21c:	00c7c7b3          	xor	a5,a5,a2
aaaab220:	01079793          	slli	a5,a5,0x10
aaaab224:	0107d793          	srli	a5,a5,0x10
aaaab228:	00f5c533          	xor	a0,a1,a5
aaaab22c:	00157513          	andi	a0,a0,1
aaaab230:	40a00533          	neg	a0,a0
aaaab234:	00e57533          	and	a0,a0,a4
aaaab238:	0017d793          	srli	a5,a5,0x1
aaaab23c:	00f54533          	xor	a0,a0,a5
aaaab240:	01051513          	slli	a0,a0,0x10
aaaab244:	01055513          	srli	a0,a0,0x10
aaaab248:	00008067          	ret

aaaab24c <core_state_transition>:
aaaab24c:	00052683          	lw	a3,0(a0)
aaaab250:	00050613          	mv	a2,a0
aaaab254:	0006c783          	lbu	a5,0(a3)
aaaab258:	28078063          	beqz	a5,aaaab4d8 <core_state_transition+0x28c>
aaaab25c:	02c00713          	li	a4,44
aaaab260:	00000513          	li	a0,0
aaaab264:	1ee78e63          	beq	a5,a4,aaaab460 <core_state_transition+0x214>
aaaab268:	02e00813          	li	a6,46
aaaab26c:	23078863          	beq	a5,a6,aaaab49c <core_state_transition+0x250>
aaaab270:	1ef86c63          	bltu	a6,a5,aaaab468 <core_state_transition+0x21c>
aaaab274:	fd578793          	addi	a5,a5,-43
aaaab278:	0fd7f793          	andi	a5,a5,253
aaaab27c:	02078663          	beqz	a5,aaaab2a8 <core_state_transition+0x5c>
aaaab280:	0045a703          	lw	a4,4(a1)
aaaab284:	0005a783          	lw	a5,0(a1)
aaaab288:	00168693          	addi	a3,a3,1
aaaab28c:	00170713          	addi	a4,a4,1
aaaab290:	00178793          	addi	a5,a5,1
aaaab294:	00e5a223          	sw	a4,4(a1)
aaaab298:	00f5a023          	sw	a5,0(a1)
aaaab29c:	00100513          	li	a0,1
aaaab2a0:	00d62023          	sw	a3,0(a2)
aaaab2a4:	00008067          	ret
aaaab2a8:	0005a503          	lw	a0,0(a1)
aaaab2ac:	00168793          	addi	a5,a3,1
aaaab2b0:	00150513          	addi	a0,a0,1
aaaab2b4:	00a5a023          	sw	a0,0(a1)
aaaab2b8:	0016c883          	lbu	a7,1(a3)
aaaab2bc:	26088463          	beqz	a7,aaaab524 <core_state_transition+0x2d8>
aaaab2c0:	20e88463          	beq	a7,a4,aaaab4c8 <core_state_transition+0x27c>
aaaab2c4:	0085a503          	lw	a0,8(a1)
aaaab2c8:	fd088713          	addi	a4,a7,-48
aaaab2cc:	0ff77713          	zext.b	a4,a4
aaaab2d0:	00900313          	li	t1,9
aaaab2d4:	00150513          	addi	a0,a0,1
aaaab2d8:	00e37e63          	bgeu	t1,a4,aaaab2f4 <core_state_transition+0xa8>
aaaab2dc:	1f088263          	beq	a7,a6,aaaab4c0 <core_state_transition+0x274>
aaaab2e0:	00a5a423          	sw	a0,8(a1)
aaaab2e4:	00268693          	addi	a3,a3,2
aaaab2e8:	00100513          	li	a0,1
aaaab2ec:	00d62023          	sw	a3,0(a2)
aaaab2f0:	00008067          	ret
aaaab2f4:	00a5a423          	sw	a0,8(a1)
aaaab2f8:	0017c683          	lbu	a3,1(a5)
aaaab2fc:	00178793          	addi	a5,a5,1
aaaab300:	18068863          	beqz	a3,aaaab490 <core_state_transition+0x244>
aaaab304:	02c00713          	li	a4,44
aaaab308:	14e68863          	beq	a3,a4,aaaab458 <core_state_transition+0x20c>
aaaab30c:	02e00713          	li	a4,46
aaaab310:	02e68863          	beq	a3,a4,aaaab340 <core_state_transition+0xf4>
aaaab314:	fd068693          	addi	a3,a3,-48
aaaab318:	0ff6f693          	zext.b	a3,a3
aaaab31c:	00900713          	li	a4,9
aaaab320:	fcd77ce3          	bgeu	a4,a3,aaaab2f8 <core_state_transition+0xac>
aaaab324:	0105a703          	lw	a4,16(a1)
aaaab328:	00100513          	li	a0,1
aaaab32c:	00178693          	addi	a3,a5,1
aaaab330:	00a707b3          	add	a5,a4,a0
aaaab334:	00f5a823          	sw	a5,16(a1)
aaaab338:	00d62023          	sw	a3,0(a2)
aaaab33c:	00008067          	ret
aaaab340:	0105a703          	lw	a4,16(a1)
aaaab344:	00170713          	addi	a4,a4,1
aaaab348:	00e5a823          	sw	a4,16(a1)
aaaab34c:	0017c683          	lbu	a3,1(a5)
aaaab350:	00178793          	addi	a5,a5,1
aaaab354:	02c00713          	li	a4,44
aaaab358:	14068e63          	beqz	a3,aaaab4b4 <core_state_transition+0x268>
aaaab35c:	18e68263          	beq	a3,a4,aaaab4e0 <core_state_transition+0x294>
aaaab360:	0df6f713          	andi	a4,a3,223
aaaab364:	04500513          	li	a0,69
aaaab368:	02a70863          	beq	a4,a0,aaaab398 <core_state_transition+0x14c>
aaaab36c:	fd068693          	addi	a3,a3,-48
aaaab370:	0ff6f693          	zext.b	a3,a3
aaaab374:	00900713          	li	a4,9
aaaab378:	fcd77ae3          	bgeu	a4,a3,aaaab34c <core_state_transition+0x100>
aaaab37c:	0145a703          	lw	a4,20(a1)
aaaab380:	00100513          	li	a0,1
aaaab384:	00178693          	addi	a3,a5,1
aaaab388:	00a707b3          	add	a5,a4,a0
aaaab38c:	00f5aa23          	sw	a5,20(a1)
aaaab390:	00d62023          	sw	a3,0(a2)
aaaab394:	00008067          	ret
aaaab398:	0145a703          	lw	a4,20(a1)
aaaab39c:	00178693          	addi	a3,a5,1
aaaab3a0:	00300513          	li	a0,3
aaaab3a4:	00170713          	addi	a4,a4,1
aaaab3a8:	00e5aa23          	sw	a4,20(a1)
aaaab3ac:	0017c703          	lbu	a4,1(a5)
aaaab3b0:	ee0708e3          	beqz	a4,aaaab2a0 <core_state_transition+0x54>
aaaab3b4:	02c00513          	li	a0,44
aaaab3b8:	14a70663          	beq	a4,a0,aaaab504 <core_state_transition+0x2b8>
aaaab3bc:	00c5a683          	lw	a3,12(a1)
aaaab3c0:	fd570713          	addi	a4,a4,-43
aaaab3c4:	0fd77713          	andi	a4,a4,253
aaaab3c8:	00168693          	addi	a3,a3,1
aaaab3cc:	00d5a623          	sw	a3,12(a1)
aaaab3d0:	00070a63          	beqz	a4,aaaab3e4 <core_state_transition+0x198>
aaaab3d4:	00278693          	addi	a3,a5,2
aaaab3d8:	00100513          	li	a0,1
aaaab3dc:	00d62023          	sw	a3,0(a2)
aaaab3e0:	00008067          	ret
aaaab3e4:	0027c703          	lbu	a4,2(a5)
aaaab3e8:	00278693          	addi	a3,a5,2
aaaab3ec:	10070263          	beqz	a4,aaaab4f0 <core_state_transition+0x2a4>
aaaab3f0:	10a70463          	beq	a4,a0,aaaab4f8 <core_state_transition+0x2ac>
aaaab3f4:	0185a803          	lw	a6,24(a1)
aaaab3f8:	fd070713          	addi	a4,a4,-48
aaaab3fc:	0ff77713          	zext.b	a4,a4
aaaab400:	00180813          	addi	a6,a6,1
aaaab404:	00900513          	li	a0,9
aaaab408:	0105ac23          	sw	a6,24(a1)
aaaab40c:	00e57863          	bgeu	a0,a4,aaaab41c <core_state_transition+0x1d0>
aaaab410:	00378693          	addi	a3,a5,3
aaaab414:	00100513          	li	a0,1
aaaab418:	e89ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab41c:	00068813          	mv	a6,a3
aaaab420:	0016c703          	lbu	a4,1(a3)
aaaab424:	00168693          	addi	a3,a3,1
aaaab428:	02c00893          	li	a7,44
aaaab42c:	fd070793          	addi	a5,a4,-48
aaaab430:	0ff7f793          	zext.b	a5,a5
aaaab434:	0c070e63          	beqz	a4,aaaab510 <core_state_transition+0x2c4>
aaaab438:	0f170063          	beq	a4,a7,aaaab518 <core_state_transition+0x2cc>
aaaab43c:	fef570e3          	bgeu	a0,a5,aaaab41c <core_state_transition+0x1d0>
aaaab440:	0045a783          	lw	a5,4(a1)
aaaab444:	00100513          	li	a0,1
aaaab448:	00280693          	addi	a3,a6,2
aaaab44c:	00a787b3          	add	a5,a5,a0
aaaab450:	00f5a223          	sw	a5,4(a1)
aaaab454:	e4dff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab458:	00078693          	mv	a3,a5
aaaab45c:	00400513          	li	a0,4
aaaab460:	00168693          	addi	a3,a3,1
aaaab464:	e3dff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab468:	fd078793          	addi	a5,a5,-48
aaaab46c:	0ff7f793          	zext.b	a5,a5
aaaab470:	00900513          	li	a0,9
aaaab474:	e0f566e3          	bltu	a0,a5,aaaab280 <core_state_transition+0x34>
aaaab478:	0005a503          	lw	a0,0(a1)
aaaab47c:	00168793          	addi	a5,a3,1
aaaab480:	00150513          	addi	a0,a0,1
aaaab484:	00a5a023          	sw	a0,0(a1)
aaaab488:	0016c683          	lbu	a3,1(a3)
aaaab48c:	e6069ee3          	bnez	a3,aaaab308 <core_state_transition+0xbc>
aaaab490:	00078693          	mv	a3,a5
aaaab494:	00400513          	li	a0,4
aaaab498:	e09ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab49c:	0005a503          	lw	a0,0(a1)
aaaab4a0:	00168793          	addi	a5,a3,1
aaaab4a4:	00150513          	addi	a0,a0,1
aaaab4a8:	00a5a023          	sw	a0,0(a1)
aaaab4ac:	0016c683          	lbu	a3,1(a3)
aaaab4b0:	ea0696e3          	bnez	a3,aaaab35c <core_state_transition+0x110>
aaaab4b4:	00078693          	mv	a3,a5
aaaab4b8:	00500513          	li	a0,5
aaaab4bc:	de5ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab4c0:	00a5a423          	sw	a0,8(a1)
aaaab4c4:	e89ff06f          	j	aaaab34c <core_state_transition+0x100>
aaaab4c8:	00078693          	mv	a3,a5
aaaab4cc:	00200513          	li	a0,2
aaaab4d0:	00168693          	addi	a3,a3,1
aaaab4d4:	dcdff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab4d8:	00000513          	li	a0,0
aaaab4dc:	dc5ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab4e0:	00078693          	mv	a3,a5
aaaab4e4:	00500513          	li	a0,5
aaaab4e8:	00168693          	addi	a3,a3,1
aaaab4ec:	db5ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab4f0:	00600513          	li	a0,6
aaaab4f4:	dadff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab4f8:	00600513          	li	a0,6
aaaab4fc:	00168693          	addi	a3,a3,1
aaaab500:	da1ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab504:	00300513          	li	a0,3
aaaab508:	00168693          	addi	a3,a3,1
aaaab50c:	d95ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab510:	00700513          	li	a0,7
aaaab514:	d8dff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab518:	00700513          	li	a0,7
aaaab51c:	00168693          	addi	a3,a3,1
aaaab520:	d81ff06f          	j	aaaab2a0 <core_state_transition+0x54>
aaaab524:	00078693          	mv	a3,a5
aaaab528:	00200513          	li	a0,2
aaaab52c:	d75ff06f          	j	aaaab2a0 <core_state_transition+0x54>

aaaab530 <calc_func>:
aaaab530:	f7010113          	addi	sp,sp,-144
aaaab534:	08812423          	sw	s0,136(sp)
aaaab538:	00051403          	lh	s0,0(a0)
aaaab53c:	08112623          	sw	ra,140(sp)
aaaab540:	40745793          	srai	a5,s0,0x7
aaaab544:	0017fe13          	andi	t3,a5,1
aaaab548:	000e0c63          	beqz	t3,aaaab560 <calc_func+0x30>
aaaab54c:	08c12083          	lw	ra,140(sp)
aaaab550:	07f47513          	andi	a0,s0,127
aaaab554:	08812403          	lw	s0,136(sp)
aaaab558:	09010113          	addi	sp,sp,144
aaaab55c:	00008067          	ret
aaaab560:	40345313          	srai	t1,s0,0x3
aaaab564:	00f37313          	andi	t1,t1,15
aaaab568:	08912223          	sw	s1,132(sp)
aaaab56c:	09212023          	sw	s2,128(sp)
aaaab570:	07312e23          	sw	s3,124(sp)
aaaab574:	00431713          	slli	a4,t1,0x4
aaaab578:	00747793          	andi	a5,s0,7
aaaab57c:	0385d983          	lhu	s3,56(a1)
aaaab580:	00050913          	mv	s2,a0
aaaab584:	00058493          	mv	s1,a1
aaaab588:	00e30333          	add	t1,t1,a4
aaaab58c:	30078c63          	beqz	a5,aaaab8a4 <calc_func+0x374>
aaaab590:	00100713          	li	a4,1
aaaab594:	08e79663          	bne	a5,a4,aaaab620 <calc_func+0xf0>
aaaab598:	0285ae83          	lw	t4,40(a1)
aaaab59c:	07412c23          	sw	s4,120(sp)
aaaab5a0:	fffff537          	lui	a0,0xfffff
aaaab5a4:	07512a23          	sw	s5,116(sp)
aaaab5a8:	07612823          	sw	s6,112(sp)
aaaab5ac:	07712623          	sw	s7,108(sp)
aaaab5b0:	07812423          	sw	s8,104(sp)
aaaab5b4:	0345a383          	lw	t2,52(a1)
aaaab5b8:	02c5af83          	lw	t6,44(a1)
aaaab5bc:	0305aa03          	lw	s4,48(a1)
aaaab5c0:	00a36533          	or	a0,t1,a0
aaaab5c4:	00000793          	li	a5,0
aaaab5c8:	00000693          	li	a3,0
aaaab5cc:	00000713          	li	a4,0
aaaab5d0:	620e86e3          	beqz	t4,aaaac3fc <calc_func+0xecc>
aaaab5d4:	001e9293          	slli	t0,t4,0x1
aaaab5d8:	005f8633          	add	a2,t6,t0
aaaab5dc:	41d00833          	neg	a6,t4
aaaab5e0:	00060693          	mv	a3,a2
aaaab5e4:	00281813          	slli	a6,a6,0x2
aaaab5e8:	00000893          	li	a7,0
aaaab5ec:	40568f33          	sub	t5,a3,t0
aaaab5f0:	000f0793          	mv	a5,t5
aaaab5f4:	0007d703          	lhu	a4,0(a5)
aaaab5f8:	00278793          	addi	a5,a5,2
aaaab5fc:	00e30733          	add	a4,t1,a4
aaaab600:	fee79f23          	sh	a4,-2(a5)
aaaab604:	fed798e3          	bne	a5,a3,aaaab5f4 <calc_func+0xc4>
aaaab608:	00188593          	addi	a1,a7,1
aaaab60c:	410f06b3          	sub	a3,t5,a6
aaaab610:	00be9463          	bne	t4,a1,aaaab618 <calc_func+0xe8>
aaaab614:	3fd0106f          	j	aaaad210 <calc_func+0x1ce0>
aaaab618:	00058893          	mv	a7,a1
aaaab61c:	fd1ff06f          	j	aaaab5ec <calc_func+0xbc>
aaaab620:	01041313          	slli	t1,s0,0x10
aaaab624:	01035313          	srli	t1,t1,0x10
aaaab628:	00040513          	mv	a0,s0
aaaab62c:	0ff57813          	zext.b	a6,a0
aaaab630:	01384633          	xor	a2,a6,s3
aaaab634:	00167613          	andi	a2,a2,1
aaaab638:	ffffa737          	lui	a4,0xffffa
aaaab63c:	00170713          	addi	a4,a4,1 # ffffa001 <_stack_top+0xfffa001>
aaaab640:	40c00633          	neg	a2,a2
aaaab644:	0019d993          	srli	s3,s3,0x1
aaaab648:	00e67633          	and	a2,a2,a4
aaaab64c:	01364633          	xor	a2,a2,s3
aaaab650:	01061613          	slli	a2,a2,0x10
aaaab654:	01065613          	srli	a2,a2,0x10
aaaab658:	00185693          	srli	a3,a6,0x1
aaaab65c:	00c6c6b3          	xor	a3,a3,a2
aaaab660:	0016f693          	andi	a3,a3,1
aaaab664:	40d006b3          	neg	a3,a3
aaaab668:	00165613          	srli	a2,a2,0x1
aaaab66c:	00e6f6b3          	and	a3,a3,a4
aaaab670:	00c6c6b3          	xor	a3,a3,a2
aaaab674:	01069693          	slli	a3,a3,0x10
aaaab678:	00285793          	srli	a5,a6,0x2
aaaab67c:	0106d693          	srli	a3,a3,0x10
aaaab680:	00d7c7b3          	xor	a5,a5,a3
aaaab684:	0017f793          	andi	a5,a5,1
aaaab688:	40f007b3          	neg	a5,a5
aaaab68c:	0016d693          	srli	a3,a3,0x1
aaaab690:	00e7f7b3          	and	a5,a5,a4
aaaab694:	00d7c7b3          	xor	a5,a5,a3
aaaab698:	01079793          	slli	a5,a5,0x10
aaaab69c:	00385893          	srli	a7,a6,0x3
aaaab6a0:	0107d793          	srli	a5,a5,0x10
aaaab6a4:	00f8c8b3          	xor	a7,a7,a5
aaaab6a8:	0018f893          	andi	a7,a7,1
aaaab6ac:	411008b3          	neg	a7,a7
aaaab6b0:	0017d793          	srli	a5,a5,0x1
aaaab6b4:	00e8f8b3          	and	a7,a7,a4
aaaab6b8:	00f8c8b3          	xor	a7,a7,a5
aaaab6bc:	01089893          	slli	a7,a7,0x10
aaaab6c0:	00485593          	srli	a1,a6,0x4
aaaab6c4:	0108d893          	srli	a7,a7,0x10
aaaab6c8:	0115c5b3          	xor	a1,a1,a7
aaaab6cc:	0015f593          	andi	a1,a1,1
aaaab6d0:	40b005b3          	neg	a1,a1
aaaab6d4:	0018d893          	srli	a7,a7,0x1
aaaab6d8:	00e5f5b3          	and	a1,a1,a4
aaaab6dc:	0115c5b3          	xor	a1,a1,a7
aaaab6e0:	01059593          	slli	a1,a1,0x10
aaaab6e4:	00585613          	srli	a2,a6,0x5
aaaab6e8:	0105d593          	srli	a1,a1,0x10
aaaab6ec:	00b64633          	xor	a2,a2,a1
aaaab6f0:	00167613          	andi	a2,a2,1
aaaab6f4:	40c00633          	neg	a2,a2
aaaab6f8:	0015d593          	srli	a1,a1,0x1
aaaab6fc:	00e67633          	and	a2,a2,a4
aaaab700:	00b64633          	xor	a2,a2,a1
aaaab704:	01061613          	slli	a2,a2,0x10
aaaab708:	00685693          	srli	a3,a6,0x6
aaaab70c:	01065613          	srli	a2,a2,0x10
aaaab710:	00c6c6b3          	xor	a3,a3,a2
aaaab714:	0016f693          	andi	a3,a3,1
aaaab718:	40d006b3          	neg	a3,a3
aaaab71c:	00165613          	srli	a2,a2,0x1
aaaab720:	00e6f6b3          	and	a3,a3,a4
aaaab724:	00c6c6b3          	xor	a3,a3,a2
aaaab728:	01069693          	slli	a3,a3,0x10
aaaab72c:	0106d693          	srli	a3,a3,0x10
aaaab730:	00785813          	srli	a6,a6,0x7
aaaab734:	00d84833          	xor	a6,a6,a3
aaaab738:	00187813          	andi	a6,a6,1
aaaab73c:	41000833          	neg	a6,a6
aaaab740:	0016d693          	srli	a3,a3,0x1
aaaab744:	00e87833          	and	a6,a6,a4
aaaab748:	00d84833          	xor	a6,a6,a3
aaaab74c:	00835793          	srli	a5,t1,0x8
aaaab750:	01081813          	slli	a6,a6,0x10
aaaab754:	0ff7f793          	zext.b	a5,a5
aaaab758:	01085813          	srli	a6,a6,0x10
aaaab75c:	0107ceb3          	xor	t4,a5,a6
aaaab760:	001efe93          	andi	t4,t4,1
aaaab764:	41d00eb3          	neg	t4,t4
aaaab768:	00eefeb3          	and	t4,t4,a4
aaaab76c:	00185813          	srli	a6,a6,0x1
aaaab770:	010ec833          	xor	a6,t4,a6
aaaab774:	01081813          	slli	a6,a6,0x10
aaaab778:	0017de13          	srli	t3,a5,0x1
aaaab77c:	01085813          	srli	a6,a6,0x10
aaaab780:	010e4e33          	xor	t3,t3,a6
aaaab784:	001e7e13          	andi	t3,t3,1
aaaab788:	41c00e33          	neg	t3,t3
aaaab78c:	00185813          	srli	a6,a6,0x1
aaaab790:	00ee7e33          	and	t3,t3,a4
aaaab794:	010e4e33          	xor	t3,t3,a6
aaaab798:	010e1e13          	slli	t3,t3,0x10
aaaab79c:	0027d313          	srli	t1,a5,0x2
aaaab7a0:	010e5e13          	srli	t3,t3,0x10
aaaab7a4:	01c34333          	xor	t1,t1,t3
aaaab7a8:	00137313          	andi	t1,t1,1
aaaab7ac:	40600333          	neg	t1,t1
aaaab7b0:	00e37333          	and	t1,t1,a4
aaaab7b4:	001e5e13          	srli	t3,t3,0x1
aaaab7b8:	01c34333          	xor	t1,t1,t3
aaaab7bc:	01031313          	slli	t1,t1,0x10
aaaab7c0:	0037d893          	srli	a7,a5,0x3
aaaab7c4:	01035313          	srli	t1,t1,0x10
aaaab7c8:	0068c8b3          	xor	a7,a7,t1
aaaab7cc:	0018f893          	andi	a7,a7,1
aaaab7d0:	411008b3          	neg	a7,a7
aaaab7d4:	00e8f8b3          	and	a7,a7,a4
aaaab7d8:	00135313          	srli	t1,t1,0x1
aaaab7dc:	0068c8b3          	xor	a7,a7,t1
aaaab7e0:	01089893          	slli	a7,a7,0x10
aaaab7e4:	0047d593          	srli	a1,a5,0x4
aaaab7e8:	0108d893          	srli	a7,a7,0x10
aaaab7ec:	0115c5b3          	xor	a1,a1,a7
aaaab7f0:	0015f593          	andi	a1,a1,1
aaaab7f4:	40b005b3          	neg	a1,a1
aaaab7f8:	00e5f5b3          	and	a1,a1,a4
aaaab7fc:	0018d893          	srli	a7,a7,0x1
aaaab800:	0115c5b3          	xor	a1,a1,a7
aaaab804:	01059593          	slli	a1,a1,0x10
aaaab808:	0057d613          	srli	a2,a5,0x5
aaaab80c:	0105d593          	srli	a1,a1,0x10
aaaab810:	00b64633          	xor	a2,a2,a1
aaaab814:	00167613          	andi	a2,a2,1
aaaab818:	40c00633          	neg	a2,a2
aaaab81c:	00e67633          	and	a2,a2,a4
aaaab820:	0015d593          	srli	a1,a1,0x1
aaaab824:	00b64633          	xor	a2,a2,a1
aaaab828:	01061613          	slli	a2,a2,0x10
aaaab82c:	0067d693          	srli	a3,a5,0x6
aaaab830:	01065613          	srli	a2,a2,0x10
aaaab834:	00c6c6b3          	xor	a3,a3,a2
aaaab838:	0016f693          	andi	a3,a3,1
aaaab83c:	40d006b3          	neg	a3,a3
aaaab840:	00e6f6b3          	and	a3,a3,a4
aaaab844:	00165613          	srli	a2,a2,0x1
aaaab848:	00c6c6b3          	xor	a3,a3,a2
aaaab84c:	01069693          	slli	a3,a3,0x10
aaaab850:	0106d693          	srli	a3,a3,0x10
aaaab854:	0077d793          	srli	a5,a5,0x7
aaaab858:	00d7c7b3          	xor	a5,a5,a3
aaaab85c:	0017f793          	andi	a5,a5,1
aaaab860:	07f57513          	andi	a0,a0,127
aaaab864:	f0047413          	andi	s0,s0,-256
aaaab868:	40f007b3          	neg	a5,a5
aaaab86c:	00856433          	or	s0,a0,s0
aaaab870:	00e7f7b3          	and	a5,a5,a4
aaaab874:	0016d693          	srli	a3,a3,0x1
aaaab878:	08c12083          	lw	ra,140(sp)
aaaab87c:	08046813          	ori	a6,s0,128
aaaab880:	00d7c7b3          	xor	a5,a5,a3
aaaab884:	08812403          	lw	s0,136(sp)
aaaab888:	02f49c23          	sh	a5,56(s1)
aaaab88c:	01091023          	sh	a6,0(s2)
aaaab890:	08412483          	lw	s1,132(sp)
aaaab894:	08012903          	lw	s2,128(sp)
aaaab898:	07c12983          	lw	s3,124(sp)
aaaab89c:	09010113          	addi	sp,sp,144
aaaab8a0:	00008067          	ret
aaaab8a4:	07612823          	sw	s6,112(sp)
aaaab8a8:	07412c23          	sw	s4,120(sp)
aaaab8ac:	07512a23          	sw	s5,116(sp)
aaaab8b0:	07712623          	sw	s7,108(sp)
aaaab8b4:	07812423          	sw	s8,104(sp)
aaaab8b8:	07912223          	sw	s9,100(sp)
aaaab8bc:	07a12023          	sw	s10,96(sp)
aaaab8c0:	05b12e23          	sw	s11,92(sp)
aaaab8c4:	02200793          	li	a5,34
aaaab8c8:	00030b13          	mv	s6,t1
aaaab8cc:	00f37463          	bgeu	t1,a5,aaaab8d4 <calc_func+0x3a4>
aaaab8d0:	00078b13          	mv	s6,a5
aaaab8d4:	0144aa83          	lw	s5,20(s1)
aaaab8d8:	010b1b13          	slli	s6,s6,0x10
aaaab8dc:	02012823          	sw	zero,48(sp)
aaaab8e0:	000ac783          	lbu	a5,0(s5)
aaaab8e4:	00012823          	sw	zero,16(sp)
aaaab8e8:	02012a23          	sw	zero,52(sp)
aaaab8ec:	00012a23          	sw	zero,20(sp)
aaaab8f0:	02012c23          	sw	zero,56(sp)
aaaab8f4:	00012c23          	sw	zero,24(sp)
aaaab8f8:	02012e23          	sw	zero,60(sp)
aaaab8fc:	00012e23          	sw	zero,28(sp)
aaaab900:	04012023          	sw	zero,64(sp)
aaaab904:	02012023          	sw	zero,32(sp)
aaaab908:	04012223          	sw	zero,68(sp)
aaaab90c:	02012223          	sw	zero,36(sp)
aaaab910:	04012423          	sw	zero,72(sp)
aaaab914:	02012423          	sw	zero,40(sp)
aaaab918:	04012623          	sw	zero,76(sp)
aaaab91c:	02012623          	sw	zero,44(sp)
aaaab920:	01512623          	sw	s5,12(sp)
aaaab924:	0184ad03          	lw	s10,24(s1)
aaaab928:	00049d83          	lh	s11,0(s1)
aaaab92c:	00249c83          	lh	s9,2(s1)
aaaab930:	410b5b13          	srai	s6,s6,0x10
aaaab934:	03010a13          	addi	s4,sp,48
aaaab938:	00c10c13          	addi	s8,sp,12
aaaab93c:	01010b93          	addi	s7,sp,16
aaaab940:	00079463          	bnez	a5,aaaab948 <calc_func+0x418>
aaaab944:	2250106f          	j	aaaad368 <calc_func+0x1e38>
aaaab948:	000a0593          	mv	a1,s4
aaaab94c:	000c0513          	mv	a0,s8
aaaab950:	00000097          	auipc	ra,0x0
aaaab954:	8fc080e7          	jalr	-1796(ra) # aaaab24c <core_state_transition>
aaaab958:	00251793          	slli	a5,a0,0x2
aaaab95c:	017787b3          	add	a5,a5,s7
aaaab960:	00c12683          	lw	a3,12(sp)
aaaab964:	0007a703          	lw	a4,0(a5)
aaaab968:	0006c683          	lbu	a3,0(a3)
aaaab96c:	00170713          	addi	a4,a4,1
aaaab970:	00e7a023          	sw	a4,0(a5)
aaaab974:	fc069ae3          	bnez	a3,aaaab948 <calc_func+0x418>
aaaab978:	01512623          	sw	s5,12(sp)
aaaab97c:	01aa8d33          	add	s10,s5,s10
aaaab980:	03aaf863          	bgeu	s5,s10,aaaab9b0 <calc_func+0x480>
aaaab984:	000a8793          	mv	a5,s5
aaaab988:	02c00613          	li	a2,44
aaaab98c:	0007c703          	lbu	a4,0(a5)
aaaab990:	01b746b3          	xor	a3,a4,s11
aaaab994:	00c70463          	beq	a4,a2,aaaab99c <calc_func+0x46c>
aaaab998:	00d78023          	sb	a3,0(a5)
aaaab99c:	016787b3          	add	a5,a5,s6
aaaab9a0:	ffa7e6e3          	bltu	a5,s10,aaaab98c <calc_func+0x45c>
aaaab9a4:	000ac783          	lbu	a5,0(s5)
aaaab9a8:	00c10c13          	addi	s8,sp,12
aaaab9ac:	02078a63          	beqz	a5,aaaab9e0 <calc_func+0x4b0>
aaaab9b0:	000a0593          	mv	a1,s4
aaaab9b4:	000c0513          	mv	a0,s8
aaaab9b8:	00000097          	auipc	ra,0x0
aaaab9bc:	894080e7          	jalr	-1900(ra) # aaaab24c <core_state_transition>
aaaab9c0:	00251793          	slli	a5,a0,0x2
aaaab9c4:	017787b3          	add	a5,a5,s7
aaaab9c8:	00c12683          	lw	a3,12(sp)
aaaab9cc:	0007a703          	lw	a4,0(a5)
aaaab9d0:	0006c683          	lbu	a3,0(a3)
aaaab9d4:	00170713          	addi	a4,a4,1
aaaab9d8:	00e7a023          	sw	a4,0(a5)
aaaab9dc:	fc069ae3          	bnez	a3,aaaab9b0 <calc_func+0x480>
aaaab9e0:	01512623          	sw	s5,12(sp)
aaaab9e4:	02c00693          	li	a3,44
aaaab9e8:	01aafe63          	bgeu	s5,s10,aaaaba04 <calc_func+0x4d4>
aaaab9ec:	000ac783          	lbu	a5,0(s5)
aaaab9f0:	0197c733          	xor	a4,a5,s9
aaaab9f4:	00d78463          	beq	a5,a3,aaaab9fc <calc_func+0x4cc>
aaaab9f8:	00ea8023          	sb	a4,0(s5)
aaaab9fc:	016a8ab3          	add	s5,s5,s6
aaaaba00:	ffaae6e3          	bltu	s5,s10,aaaab9ec <calc_func+0x4bc>
aaaaba04:	0384d803          	lhu	a6,56(s1)
aaaaba08:	ffffa7b7          	lui	a5,0xffffa
aaaaba0c:	000b8593          	mv	a1,s7
aaaaba10:	00178793          	addi	a5,a5,1 # ffffa001 <_stack_top+0xfffa001>
aaaaba14:	000a0513          	mv	a0,s4
aaaaba18:	0005a683          	lw	a3,0(a1)
aaaaba1c:	0019d313          	srli	t1,s3,0x1
aaaaba20:	00052703          	lw	a4,0(a0) # fffff000 <_stack_top+0xffff000>
aaaaba24:	0ff6f613          	zext.b	a2,a3
aaaaba28:	013648b3          	xor	a7,a2,s3
aaaaba2c:	0018f893          	andi	a7,a7,1
aaaaba30:	411008b3          	neg	a7,a7
aaaaba34:	00f8f8b3          	and	a7,a7,a5
aaaaba38:	0068c8b3          	xor	a7,a7,t1
aaaaba3c:	01089893          	slli	a7,a7,0x10
aaaaba40:	0108d893          	srli	a7,a7,0x10
aaaaba44:	00165e13          	srli	t3,a2,0x1
aaaaba48:	011e4e33          	xor	t3,t3,a7
aaaaba4c:	001e7e13          	andi	t3,t3,1
aaaaba50:	41c00e33          	neg	t3,t3
aaaaba54:	0018d893          	srli	a7,a7,0x1
aaaaba58:	00fe7e33          	and	t3,t3,a5
aaaaba5c:	011e4e33          	xor	t3,t3,a7
aaaaba60:	010e1e13          	slli	t3,t3,0x10
aaaaba64:	00265313          	srli	t1,a2,0x2
aaaaba68:	010e5e13          	srli	t3,t3,0x10
aaaaba6c:	01c34333          	xor	t1,t1,t3
aaaaba70:	00137313          	andi	t1,t1,1
aaaaba74:	40600333          	neg	t1,t1
aaaaba78:	001e5e13          	srli	t3,t3,0x1
aaaaba7c:	00f37333          	and	t1,t1,a5
aaaaba80:	01c34333          	xor	t1,t1,t3
aaaaba84:	01031313          	slli	t1,t1,0x10
aaaaba88:	00365f13          	srli	t5,a2,0x3
aaaaba8c:	01035313          	srli	t1,t1,0x10
aaaaba90:	006f4f33          	xor	t5,t5,t1
aaaaba94:	001f7f13          	andi	t5,t5,1
aaaaba98:	41e00f33          	neg	t5,t5
aaaaba9c:	00135313          	srli	t1,t1,0x1
aaaabaa0:	00ff7f33          	and	t5,t5,a5
aaaabaa4:	006f4f33          	xor	t5,t5,t1
aaaabaa8:	010f1f13          	slli	t5,t5,0x10
aaaabaac:	00465893          	srli	a7,a2,0x4
aaaabab0:	010f5f13          	srli	t5,t5,0x10
aaaabab4:	01e8c8b3          	xor	a7,a7,t5
aaaabab8:	0018f893          	andi	a7,a7,1
aaaababc:	411008b3          	neg	a7,a7
aaaabac0:	001f5f13          	srli	t5,t5,0x1
aaaabac4:	00f8f8b3          	and	a7,a7,a5
aaaabac8:	01e8c8b3          	xor	a7,a7,t5
aaaabacc:	01089893          	slli	a7,a7,0x10
aaaabad0:	00565e93          	srli	t4,a2,0x5
aaaabad4:	0108d893          	srli	a7,a7,0x10
aaaabad8:	011eceb3          	xor	t4,t4,a7
aaaabadc:	001efe93          	andi	t4,t4,1
aaaabae0:	41d00eb3          	neg	t4,t4
aaaabae4:	0018d893          	srli	a7,a7,0x1
aaaabae8:	00fefeb3          	and	t4,t4,a5
aaaabaec:	011eceb3          	xor	t4,t4,a7
aaaabaf0:	010e9e93          	slli	t4,t4,0x10
aaaabaf4:	00665e13          	srli	t3,a2,0x6
aaaabaf8:	010ede93          	srli	t4,t4,0x10
aaaabafc:	01de4e33          	xor	t3,t3,t4
aaaabb00:	001e7e13          	andi	t3,t3,1
aaaabb04:	41c00e33          	neg	t3,t3
aaaabb08:	001ede93          	srli	t4,t4,0x1
aaaabb0c:	00fe7e33          	and	t3,t3,a5
aaaabb10:	01de4e33          	xor	t3,t3,t4
aaaabb14:	010e1e13          	slli	t3,t3,0x10
aaaabb18:	010e5e13          	srli	t3,t3,0x10
aaaabb1c:	00765613          	srli	a2,a2,0x7
aaaabb20:	01c64633          	xor	a2,a2,t3
aaaabb24:	00167613          	andi	a2,a2,1
aaaabb28:	40c00633          	neg	a2,a2
aaaabb2c:	001e5e13          	srli	t3,t3,0x1
aaaabb30:	00f67633          	and	a2,a2,a5
aaaabb34:	01069313          	slli	t1,a3,0x10
aaaabb38:	01c64633          	xor	a2,a2,t3
aaaabb3c:	01035313          	srli	t1,t1,0x10
aaaabb40:	01061613          	slli	a2,a2,0x10
aaaabb44:	00835313          	srli	t1,t1,0x8
aaaabb48:	01065613          	srli	a2,a2,0x10
aaaabb4c:	00c342b3          	xor	t0,t1,a2
aaaabb50:	0012f293          	andi	t0,t0,1
aaaabb54:	405002b3          	neg	t0,t0
aaaabb58:	00165613          	srli	a2,a2,0x1
aaaabb5c:	00f2f2b3          	and	t0,t0,a5
aaaabb60:	00c2c2b3          	xor	t0,t0,a2
aaaabb64:	01029293          	slli	t0,t0,0x10
aaaabb68:	00135f93          	srli	t6,t1,0x1
aaaabb6c:	0102d293          	srli	t0,t0,0x10
aaaabb70:	005fcfb3          	xor	t6,t6,t0
aaaabb74:	001fff93          	andi	t6,t6,1
aaaabb78:	41f00fb3          	neg	t6,t6
aaaabb7c:	0012d293          	srli	t0,t0,0x1
aaaabb80:	00ffffb3          	and	t6,t6,a5
aaaabb84:	005fcfb3          	xor	t6,t6,t0
aaaabb88:	010f9f93          	slli	t6,t6,0x10
aaaabb8c:	00235893          	srli	a7,t1,0x2
aaaabb90:	010fdf93          	srli	t6,t6,0x10
aaaabb94:	01f8c8b3          	xor	a7,a7,t6
aaaabb98:	0018f893          	andi	a7,a7,1
aaaabb9c:	411008b3          	neg	a7,a7
aaaabba0:	001fdf93          	srli	t6,t6,0x1
aaaabba4:	00f8f8b3          	and	a7,a7,a5
aaaabba8:	01f8c8b3          	xor	a7,a7,t6
aaaabbac:	01089893          	slli	a7,a7,0x10
aaaabbb0:	00335f13          	srli	t5,t1,0x3
aaaabbb4:	0108d893          	srli	a7,a7,0x10
aaaabbb8:	011f4f33          	xor	t5,t5,a7
aaaabbbc:	001f7f13          	andi	t5,t5,1
aaaabbc0:	41e00f33          	neg	t5,t5
aaaabbc4:	0018d893          	srli	a7,a7,0x1
aaaabbc8:	00ff7f33          	and	t5,t5,a5
aaaabbcc:	011f4f33          	xor	t5,t5,a7
aaaabbd0:	010f1f13          	slli	t5,t5,0x10
aaaabbd4:	00435e93          	srli	t4,t1,0x4
aaaabbd8:	010f5f13          	srli	t5,t5,0x10
aaaabbdc:	01eeceb3          	xor	t4,t4,t5
aaaabbe0:	001efe93          	andi	t4,t4,1
aaaabbe4:	41d00eb3          	neg	t4,t4
aaaabbe8:	001f5f13          	srli	t5,t5,0x1
aaaabbec:	00fefeb3          	and	t4,t4,a5
aaaabbf0:	01eeceb3          	xor	t4,t4,t5
aaaabbf4:	010e9e93          	slli	t4,t4,0x10
aaaabbf8:	00535e13          	srli	t3,t1,0x5
aaaabbfc:	010ede93          	srli	t4,t4,0x10
aaaabc00:	01de4e33          	xor	t3,t3,t4
aaaabc04:	001e7e13          	andi	t3,t3,1
aaaabc08:	41c00e33          	neg	t3,t3
aaaabc0c:	001ede93          	srli	t4,t4,0x1
aaaabc10:	00fe7e33          	and	t3,t3,a5
aaaabc14:	01de4e33          	xor	t3,t3,t4
aaaabc18:	010e1e13          	slli	t3,t3,0x10
aaaabc1c:	00635613          	srli	a2,t1,0x6
aaaabc20:	010e5e13          	srli	t3,t3,0x10
aaaabc24:	01c64633          	xor	a2,a2,t3
aaaabc28:	00167613          	andi	a2,a2,1
aaaabc2c:	40c00633          	neg	a2,a2
aaaabc30:	001e5e13          	srli	t3,t3,0x1
aaaabc34:	00f67633          	and	a2,a2,a5
aaaabc38:	01c64633          	xor	a2,a2,t3
aaaabc3c:	01061613          	slli	a2,a2,0x10
aaaabc40:	01065613          	srli	a2,a2,0x10
aaaabc44:	00735313          	srli	t1,t1,0x7
aaaabc48:	00c34333          	xor	t1,t1,a2
aaaabc4c:	00137313          	andi	t1,t1,1
aaaabc50:	40600333          	neg	t1,t1
aaaabc54:	00165613          	srli	a2,a2,0x1
aaaabc58:	00f37333          	and	t1,t1,a5
aaaabc5c:	00c34333          	xor	t1,t1,a2
aaaabc60:	0106d293          	srli	t0,a3,0x10
aaaabc64:	01031313          	slli	t1,t1,0x10
aaaabc68:	0ff2f293          	zext.b	t0,t0
aaaabc6c:	01035313          	srli	t1,t1,0x10
aaaabc70:	0062c3b3          	xor	t2,t0,t1
aaaabc74:	0013f393          	andi	t2,t2,1
aaaabc78:	407003b3          	neg	t2,t2
aaaabc7c:	00f3f3b3          	and	t2,t2,a5
aaaabc80:	00135313          	srli	t1,t1,0x1
aaaabc84:	0063c333          	xor	t1,t2,t1
aaaabc88:	01031313          	slli	t1,t1,0x10
aaaabc8c:	0012df93          	srli	t6,t0,0x1
aaaabc90:	01035313          	srli	t1,t1,0x10
aaaabc94:	006fcfb3          	xor	t6,t6,t1
aaaabc98:	001fff93          	andi	t6,t6,1
aaaabc9c:	41f00fb3          	neg	t6,t6
aaaabca0:	00135313          	srli	t1,t1,0x1
aaaabca4:	00ffffb3          	and	t6,t6,a5
aaaabca8:	006fcfb3          	xor	t6,t6,t1
aaaabcac:	010f9f93          	slli	t6,t6,0x10
aaaabcb0:	0022d893          	srli	a7,t0,0x2
aaaabcb4:	010fdf93          	srli	t6,t6,0x10
aaaabcb8:	01f8c8b3          	xor	a7,a7,t6
aaaabcbc:	0018f893          	andi	a7,a7,1
aaaabcc0:	411008b3          	neg	a7,a7
aaaabcc4:	001fdf93          	srli	t6,t6,0x1
aaaabcc8:	00f8f8b3          	and	a7,a7,a5
aaaabccc:	01f8c8b3          	xor	a7,a7,t6
aaaabcd0:	01089893          	slli	a7,a7,0x10
aaaabcd4:	0032df13          	srli	t5,t0,0x3
aaaabcd8:	0108d893          	srli	a7,a7,0x10
aaaabcdc:	011f4f33          	xor	t5,t5,a7
aaaabce0:	001f7f13          	andi	t5,t5,1
aaaabce4:	41e00f33          	neg	t5,t5
aaaabce8:	0018d893          	srli	a7,a7,0x1
aaaabcec:	00ff7f33          	and	t5,t5,a5
aaaabcf0:	011f4f33          	xor	t5,t5,a7
aaaabcf4:	010f1f13          	slli	t5,t5,0x10
aaaabcf8:	0042de93          	srli	t4,t0,0x4
aaaabcfc:	010f5f13          	srli	t5,t5,0x10
aaaabd00:	01eeceb3          	xor	t4,t4,t5
aaaabd04:	001efe93          	andi	t4,t4,1
aaaabd08:	41d00eb3          	neg	t4,t4
aaaabd0c:	001f5f13          	srli	t5,t5,0x1
aaaabd10:	00fefeb3          	and	t4,t4,a5
aaaabd14:	01eeceb3          	xor	t4,t4,t5
aaaabd18:	010e9e93          	slli	t4,t4,0x10
aaaabd1c:	0052de13          	srli	t3,t0,0x5
aaaabd20:	010ede93          	srli	t4,t4,0x10
aaaabd24:	01de4e33          	xor	t3,t3,t4
aaaabd28:	001e7e13          	andi	t3,t3,1
aaaabd2c:	41c00e33          	neg	t3,t3
aaaabd30:	001ede93          	srli	t4,t4,0x1
aaaabd34:	00fe7e33          	and	t3,t3,a5
aaaabd38:	01de4e33          	xor	t3,t3,t4
aaaabd3c:	010e1e13          	slli	t3,t3,0x10
aaaabd40:	0062d613          	srli	a2,t0,0x6
aaaabd44:	010e5e13          	srli	t3,t3,0x10
aaaabd48:	01c64633          	xor	a2,a2,t3
aaaabd4c:	00167613          	andi	a2,a2,1
aaaabd50:	40c00633          	neg	a2,a2
aaaabd54:	001e5e13          	srli	t3,t3,0x1
aaaabd58:	00f67633          	and	a2,a2,a5
aaaabd5c:	01c64633          	xor	a2,a2,t3
aaaabd60:	01061613          	slli	a2,a2,0x10
aaaabd64:	01065613          	srli	a2,a2,0x10
aaaabd68:	0072d293          	srli	t0,t0,0x7
aaaabd6c:	00c2c2b3          	xor	t0,t0,a2
aaaabd70:	0012f293          	andi	t0,t0,1
aaaabd74:	405002b3          	neg	t0,t0
aaaabd78:	00165613          	srli	a2,a2,0x1
aaaabd7c:	00f2f2b3          	and	t0,t0,a5
aaaabd80:	00c2c2b3          	xor	t0,t0,a2
aaaabd84:	01029293          	slli	t0,t0,0x10
aaaabd88:	0186d693          	srli	a3,a3,0x18
aaaabd8c:	0102d293          	srli	t0,t0,0x10
aaaabd90:	0056c633          	xor	a2,a3,t0
aaaabd94:	00167613          	andi	a2,a2,1
aaaabd98:	40c00633          	neg	a2,a2
aaaabd9c:	0012d293          	srli	t0,t0,0x1
aaaabda0:	00f67633          	and	a2,a2,a5
aaaabda4:	00564633          	xor	a2,a2,t0
aaaabda8:	01061613          	slli	a2,a2,0x10
aaaabdac:	0016d313          	srli	t1,a3,0x1
aaaabdb0:	01065613          	srli	a2,a2,0x10
aaaabdb4:	00c34333          	xor	t1,t1,a2
aaaabdb8:	00137313          	andi	t1,t1,1
aaaabdbc:	40600333          	neg	t1,t1
aaaabdc0:	00f37333          	and	t1,t1,a5
aaaabdc4:	00165613          	srli	a2,a2,0x1
aaaabdc8:	00c34633          	xor	a2,t1,a2
aaaabdcc:	01061613          	slli	a2,a2,0x10
aaaabdd0:	0026df93          	srli	t6,a3,0x2
aaaabdd4:	01065613          	srli	a2,a2,0x10
aaaabdd8:	00cfcfb3          	xor	t6,t6,a2
aaaabddc:	001fff93          	andi	t6,t6,1
aaaabde0:	41f00fb3          	neg	t6,t6
aaaabde4:	00165613          	srli	a2,a2,0x1
aaaabde8:	00ffffb3          	and	t6,t6,a5
aaaabdec:	00cfcfb3          	xor	t6,t6,a2
aaaabdf0:	010f9f93          	slli	t6,t6,0x10
aaaabdf4:	0036d893          	srli	a7,a3,0x3
aaaabdf8:	010fdf93          	srli	t6,t6,0x10
aaaabdfc:	01f8c633          	xor	a2,a7,t6
aaaabe00:	00167613          	andi	a2,a2,1
aaaabe04:	40c00633          	neg	a2,a2
aaaabe08:	001fdf93          	srli	t6,t6,0x1
aaaabe0c:	00f67633          	and	a2,a2,a5
aaaabe10:	01f64633          	xor	a2,a2,t6
aaaabe14:	01061613          	slli	a2,a2,0x10
aaaabe18:	0046df13          	srli	t5,a3,0x4
aaaabe1c:	01065613          	srli	a2,a2,0x10
aaaabe20:	00cf4f33          	xor	t5,t5,a2
aaaabe24:	001f7f13          	andi	t5,t5,1
aaaabe28:	41e00f33          	neg	t5,t5
aaaabe2c:	00165613          	srli	a2,a2,0x1
aaaabe30:	00ff7f33          	and	t5,t5,a5
aaaabe34:	00cf4f33          	xor	t5,t5,a2
aaaabe38:	010f1f13          	slli	t5,t5,0x10
aaaabe3c:	0056de93          	srli	t4,a3,0x5
aaaabe40:	010f5f13          	srli	t5,t5,0x10
aaaabe44:	01eec633          	xor	a2,t4,t5
aaaabe48:	00167613          	andi	a2,a2,1
aaaabe4c:	40c00633          	neg	a2,a2
aaaabe50:	001f5f13          	srli	t5,t5,0x1
aaaabe54:	00f67633          	and	a2,a2,a5
aaaabe58:	01e64633          	xor	a2,a2,t5
aaaabe5c:	01061613          	slli	a2,a2,0x10
aaaabe60:	0066d393          	srli	t2,a3,0x6
aaaabe64:	01065613          	srli	a2,a2,0x10
aaaabe68:	00c3c3b3          	xor	t2,t2,a2
aaaabe6c:	0013f393          	andi	t2,t2,1
aaaabe70:	407003b3          	neg	t2,t2
aaaabe74:	00165613          	srli	a2,a2,0x1
aaaabe78:	00f3f3b3          	and	t2,t2,a5
aaaabe7c:	00c3c3b3          	xor	t2,t2,a2
aaaabe80:	01039393          	slli	t2,t2,0x10
aaaabe84:	0076de13          	srli	t3,a3,0x7
aaaabe88:	0103d393          	srli	t2,t2,0x10
aaaabe8c:	007e4633          	xor	a2,t3,t2
aaaabe90:	00167613          	andi	a2,a2,1
aaaabe94:	40c00633          	neg	a2,a2
aaaabe98:	0013d393          	srli	t2,t2,0x1
aaaabe9c:	00f67633          	and	a2,a2,a5
aaaabea0:	00764633          	xor	a2,a2,t2
aaaabea4:	01061613          	slli	a2,a2,0x10
aaaabea8:	0ff77693          	zext.b	a3,a4
aaaabeac:	01065613          	srli	a2,a2,0x10
aaaabeb0:	0036d893          	srli	a7,a3,0x3
aaaabeb4:	0056df13          	srli	t5,a3,0x5
aaaabeb8:	0076de13          	srli	t3,a3,0x7
aaaabebc:	0016d313          	srli	t1,a3,0x1
aaaabec0:	0026d293          	srli	t0,a3,0x2
aaaabec4:	0046df93          	srli	t6,a3,0x4
aaaabec8:	0066de93          	srli	t4,a3,0x6
aaaabecc:	00c6c6b3          	xor	a3,a3,a2
aaaabed0:	0016f693          	andi	a3,a3,1
aaaabed4:	40d006b3          	neg	a3,a3
aaaabed8:	00165613          	srli	a2,a2,0x1
aaaabedc:	00f6f6b3          	and	a3,a3,a5
aaaabee0:	00c6c6b3          	xor	a3,a3,a2
aaaabee4:	01069693          	slli	a3,a3,0x10
aaaabee8:	0106d693          	srli	a3,a3,0x10
aaaabeec:	00d34333          	xor	t1,t1,a3
aaaabef0:	00137313          	andi	t1,t1,1
aaaabef4:	40600333          	neg	t1,t1
aaaabef8:	00f37333          	and	t1,t1,a5
aaaabefc:	0016d693          	srli	a3,a3,0x1
aaaabf00:	00d346b3          	xor	a3,t1,a3
aaaabf04:	01069693          	slli	a3,a3,0x10
aaaabf08:	0106d693          	srli	a3,a3,0x10
aaaabf0c:	00d2c2b3          	xor	t0,t0,a3
aaaabf10:	0012f293          	andi	t0,t0,1
aaaabf14:	405002b3          	neg	t0,t0
aaaabf18:	0016d693          	srli	a3,a3,0x1
aaaabf1c:	00f2f2b3          	and	t0,t0,a5
aaaabf20:	00d2c2b3          	xor	t0,t0,a3
aaaabf24:	01029293          	slli	t0,t0,0x10
aaaabf28:	0102d293          	srli	t0,t0,0x10
aaaabf2c:	0058c6b3          	xor	a3,a7,t0
aaaabf30:	0016f693          	andi	a3,a3,1
aaaabf34:	40d006b3          	neg	a3,a3
aaaabf38:	0012d293          	srli	t0,t0,0x1
aaaabf3c:	00f6f6b3          	and	a3,a3,a5
aaaabf40:	0056c6b3          	xor	a3,a3,t0
aaaabf44:	01069693          	slli	a3,a3,0x10
aaaabf48:	0106d693          	srli	a3,a3,0x10
aaaabf4c:	00dfcfb3          	xor	t6,t6,a3
aaaabf50:	001fff93          	andi	t6,t6,1
aaaabf54:	41f00fb3          	neg	t6,t6
aaaabf58:	0016d693          	srli	a3,a3,0x1
aaaabf5c:	00ffffb3          	and	t6,t6,a5
aaaabf60:	00dfcfb3          	xor	t6,t6,a3
aaaabf64:	010f9f93          	slli	t6,t6,0x10
aaaabf68:	010fdf93          	srli	t6,t6,0x10
aaaabf6c:	01ff46b3          	xor	a3,t5,t6
aaaabf70:	0016f693          	andi	a3,a3,1
aaaabf74:	40d006b3          	neg	a3,a3
aaaabf78:	001fdf93          	srli	t6,t6,0x1
aaaabf7c:	00f6f6b3          	and	a3,a3,a5
aaaabf80:	01f6c6b3          	xor	a3,a3,t6
aaaabf84:	01069693          	slli	a3,a3,0x10
aaaabf88:	0106d693          	srli	a3,a3,0x10
aaaabf8c:	00deceb3          	xor	t4,t4,a3
aaaabf90:	001efe93          	andi	t4,t4,1
aaaabf94:	41d00eb3          	neg	t4,t4
aaaabf98:	0016d693          	srli	a3,a3,0x1
aaaabf9c:	00fefeb3          	and	t4,t4,a5
aaaabfa0:	00deceb3          	xor	t4,t4,a3
aaaabfa4:	010e9e93          	slli	t4,t4,0x10
aaaabfa8:	010ede93          	srli	t4,t4,0x10
aaaabfac:	01de46b3          	xor	a3,t3,t4
aaaabfb0:	0016f693          	andi	a3,a3,1
aaaabfb4:	40d006b3          	neg	a3,a3
aaaabfb8:	001ede93          	srli	t4,t4,0x1
aaaabfbc:	00f6f6b3          	and	a3,a3,a5
aaaabfc0:	01071613          	slli	a2,a4,0x10
aaaabfc4:	01d6c6b3          	xor	a3,a3,t4
aaaabfc8:	01065613          	srli	a2,a2,0x10
aaaabfcc:	01069693          	slli	a3,a3,0x10
aaaabfd0:	00865613          	srli	a2,a2,0x8
aaaabfd4:	0106d693          	srli	a3,a3,0x10
aaaabfd8:	00365293          	srli	t0,a2,0x3
aaaabfdc:	00165313          	srli	t1,a2,0x1
aaaabfe0:	00265393          	srli	t2,a2,0x2
aaaabfe4:	00465893          	srli	a7,a2,0x4
aaaabfe8:	00565f93          	srli	t6,a2,0x5
aaaabfec:	00665f13          	srli	t5,a2,0x6
aaaabff0:	00765e93          	srli	t4,a2,0x7
aaaabff4:	00d64633          	xor	a2,a2,a3
aaaabff8:	00167613          	andi	a2,a2,1
aaaabffc:	40c00633          	neg	a2,a2
aaaac000:	0016d693          	srli	a3,a3,0x1
aaaac004:	00f67633          	and	a2,a2,a5
aaaac008:	00d64633          	xor	a2,a2,a3
aaaac00c:	01061613          	slli	a2,a2,0x10
aaaac010:	01065613          	srli	a2,a2,0x10
aaaac014:	00c34333          	xor	t1,t1,a2
aaaac018:	00137313          	andi	t1,t1,1
aaaac01c:	40600333          	neg	t1,t1
aaaac020:	00f37333          	and	t1,t1,a5
aaaac024:	00165613          	srli	a2,a2,0x1
aaaac028:	00c34633          	xor	a2,t1,a2
aaaac02c:	01061613          	slli	a2,a2,0x10
aaaac030:	01065613          	srli	a2,a2,0x10
aaaac034:	00c3c3b3          	xor	t2,t2,a2
aaaac038:	0013f393          	andi	t2,t2,1
aaaac03c:	407003b3          	neg	t2,t2
aaaac040:	00165613          	srli	a2,a2,0x1
aaaac044:	00f3f3b3          	and	t2,t2,a5
aaaac048:	00c3c3b3          	xor	t2,t2,a2
aaaac04c:	01039393          	slli	t2,t2,0x10
aaaac050:	0103d393          	srli	t2,t2,0x10
aaaac054:	0072c633          	xor	a2,t0,t2
aaaac058:	00167613          	andi	a2,a2,1
aaaac05c:	40c00633          	neg	a2,a2
aaaac060:	0013d393          	srli	t2,t2,0x1
aaaac064:	00f67633          	and	a2,a2,a5
aaaac068:	00764633          	xor	a2,a2,t2
aaaac06c:	01061613          	slli	a2,a2,0x10
aaaac070:	01065613          	srli	a2,a2,0x10
aaaac074:	00c8c8b3          	xor	a7,a7,a2
aaaac078:	0018f893          	andi	a7,a7,1
aaaac07c:	411008b3          	neg	a7,a7
aaaac080:	00165613          	srli	a2,a2,0x1
aaaac084:	00f8f8b3          	and	a7,a7,a5
aaaac088:	00c8c8b3          	xor	a7,a7,a2
aaaac08c:	01089893          	slli	a7,a7,0x10
aaaac090:	0108d893          	srli	a7,a7,0x10
aaaac094:	011fcfb3          	xor	t6,t6,a7
aaaac098:	001fff93          	andi	t6,t6,1
aaaac09c:	41f00fb3          	neg	t6,t6
aaaac0a0:	0018d893          	srli	a7,a7,0x1
aaaac0a4:	00ffffb3          	and	t6,t6,a5
aaaac0a8:	011fcfb3          	xor	t6,t6,a7
aaaac0ac:	010f9f93          	slli	t6,t6,0x10
aaaac0b0:	010fdf93          	srli	t6,t6,0x10
aaaac0b4:	01ff4f33          	xor	t5,t5,t6
aaaac0b8:	001f7f13          	andi	t5,t5,1
aaaac0bc:	41e00f33          	neg	t5,t5
aaaac0c0:	001fdf93          	srli	t6,t6,0x1
aaaac0c4:	00ff7f33          	and	t5,t5,a5
aaaac0c8:	01ff4f33          	xor	t5,t5,t6
aaaac0cc:	010f1f13          	slli	t5,t5,0x10
aaaac0d0:	010f5f13          	srli	t5,t5,0x10
aaaac0d4:	01eeceb3          	xor	t4,t4,t5
aaaac0d8:	001efe93          	andi	t4,t4,1
aaaac0dc:	41d00eb3          	neg	t4,t4
aaaac0e0:	001f5f13          	srli	t5,t5,0x1
aaaac0e4:	00fefeb3          	and	t4,t4,a5
aaaac0e8:	01eeceb3          	xor	t4,t4,t5
aaaac0ec:	01075693          	srli	a3,a4,0x10
aaaac0f0:	010e9e93          	slli	t4,t4,0x10
aaaac0f4:	0ff6f693          	zext.b	a3,a3
aaaac0f8:	010ede93          	srli	t4,t4,0x10
aaaac0fc:	0026d313          	srli	t1,a3,0x2
aaaac100:	0046d613          	srli	a2,a3,0x4
aaaac104:	0016de13          	srli	t3,a3,0x1
aaaac108:	0036d393          	srli	t2,a3,0x3
aaaac10c:	0056d893          	srli	a7,a3,0x5
aaaac110:	0066d293          	srli	t0,a3,0x6
aaaac114:	0076df93          	srli	t6,a3,0x7
aaaac118:	01d6c6b3          	xor	a3,a3,t4
aaaac11c:	0016f693          	andi	a3,a3,1
aaaac120:	40d006b3          	neg	a3,a3
aaaac124:	001ede93          	srli	t4,t4,0x1
aaaac128:	00f6f6b3          	and	a3,a3,a5
aaaac12c:	01d6c6b3          	xor	a3,a3,t4
aaaac130:	01069693          	slli	a3,a3,0x10
aaaac134:	0106d693          	srli	a3,a3,0x10
aaaac138:	00de4e33          	xor	t3,t3,a3
aaaac13c:	001e7e13          	andi	t3,t3,1
aaaac140:	41c00e33          	neg	t3,t3
aaaac144:	0016d693          	srli	a3,a3,0x1
aaaac148:	00fe7e33          	and	t3,t3,a5
aaaac14c:	00de4e33          	xor	t3,t3,a3
aaaac150:	010e1e13          	slli	t3,t3,0x10
aaaac154:	010e5e13          	srli	t3,t3,0x10
aaaac158:	01c346b3          	xor	a3,t1,t3
aaaac15c:	0016f693          	andi	a3,a3,1
aaaac160:	40d006b3          	neg	a3,a3
aaaac164:	001e5e13          	srli	t3,t3,0x1
aaaac168:	00f6f6b3          	and	a3,a3,a5
aaaac16c:	01c6c6b3          	xor	a3,a3,t3
aaaac170:	01069693          	slli	a3,a3,0x10
aaaac174:	0106d693          	srli	a3,a3,0x10
aaaac178:	00d3c3b3          	xor	t2,t2,a3
aaaac17c:	0013f393          	andi	t2,t2,1
aaaac180:	407003b3          	neg	t2,t2
aaaac184:	0016d693          	srli	a3,a3,0x1
aaaac188:	00f3f3b3          	and	t2,t2,a5
aaaac18c:	00d3c3b3          	xor	t2,t2,a3
aaaac190:	01039393          	slli	t2,t2,0x10
aaaac194:	0103d393          	srli	t2,t2,0x10
aaaac198:	007646b3          	xor	a3,a2,t2
aaaac19c:	0016f693          	andi	a3,a3,1
aaaac1a0:	40d006b3          	neg	a3,a3
aaaac1a4:	00f6f6b3          	and	a3,a3,a5
aaaac1a8:	0013d393          	srli	t2,t2,0x1
aaaac1ac:	0076c6b3          	xor	a3,a3,t2
aaaac1b0:	01069693          	slli	a3,a3,0x10
aaaac1b4:	0106d693          	srli	a3,a3,0x10
aaaac1b8:	00d8c8b3          	xor	a7,a7,a3
aaaac1bc:	0018f893          	andi	a7,a7,1
aaaac1c0:	411008b3          	neg	a7,a7
aaaac1c4:	0016d693          	srli	a3,a3,0x1
aaaac1c8:	00f8f8b3          	and	a7,a7,a5
aaaac1cc:	00d8c8b3          	xor	a7,a7,a3
aaaac1d0:	01089893          	slli	a7,a7,0x10
aaaac1d4:	0108d893          	srli	a7,a7,0x10
aaaac1d8:	0112c2b3          	xor	t0,t0,a7
aaaac1dc:	0012f293          	andi	t0,t0,1
aaaac1e0:	405002b3          	neg	t0,t0
aaaac1e4:	0018d893          	srli	a7,a7,0x1
aaaac1e8:	00f2f2b3          	and	t0,t0,a5
aaaac1ec:	0112c2b3          	xor	t0,t0,a7
aaaac1f0:	01029293          	slli	t0,t0,0x10
aaaac1f4:	0102d293          	srli	t0,t0,0x10
aaaac1f8:	005fcfb3          	xor	t6,t6,t0
aaaac1fc:	001fff93          	andi	t6,t6,1
aaaac200:	41f00fb3          	neg	t6,t6
aaaac204:	00ffffb3          	and	t6,t6,a5
aaaac208:	0012d293          	srli	t0,t0,0x1
aaaac20c:	005fcfb3          	xor	t6,t6,t0
aaaac210:	010f9f93          	slli	t6,t6,0x10
aaaac214:	01875713          	srli	a4,a4,0x18
aaaac218:	010fdf93          	srli	t6,t6,0x10
aaaac21c:	00175f13          	srli	t5,a4,0x1
aaaac220:	00275e93          	srli	t4,a4,0x2
aaaac224:	00375e13          	srli	t3,a4,0x3
aaaac228:	00475313          	srli	t1,a4,0x4
aaaac22c:	00575613          	srli	a2,a4,0x5
aaaac230:	00675693          	srli	a3,a4,0x6
aaaac234:	00775893          	srli	a7,a4,0x7
aaaac238:	01f74733          	xor	a4,a4,t6
aaaac23c:	00177713          	andi	a4,a4,1
aaaac240:	40e00733          	neg	a4,a4
aaaac244:	00f77733          	and	a4,a4,a5
aaaac248:	001fdf93          	srli	t6,t6,0x1
aaaac24c:	01f74733          	xor	a4,a4,t6
aaaac250:	01071713          	slli	a4,a4,0x10
aaaac254:	01075713          	srli	a4,a4,0x10
aaaac258:	00ef4f33          	xor	t5,t5,a4
aaaac25c:	001f7f13          	andi	t5,t5,1
aaaac260:	41e00f33          	neg	t5,t5
aaaac264:	00175713          	srli	a4,a4,0x1
aaaac268:	00ff7f33          	and	t5,t5,a5
aaaac26c:	00ef4f33          	xor	t5,t5,a4
aaaac270:	010f1f13          	slli	t5,t5,0x10
aaaac274:	010f5f13          	srli	t5,t5,0x10
aaaac278:	01eec733          	xor	a4,t4,t5
aaaac27c:	00177713          	andi	a4,a4,1
aaaac280:	40e00733          	neg	a4,a4
aaaac284:	00f77733          	and	a4,a4,a5
aaaac288:	001f5f13          	srli	t5,t5,0x1
aaaac28c:	01e74733          	xor	a4,a4,t5
aaaac290:	01071713          	slli	a4,a4,0x10
aaaac294:	01075713          	srli	a4,a4,0x10
aaaac298:	00ee4e33          	xor	t3,t3,a4
aaaac29c:	001e7e13          	andi	t3,t3,1
aaaac2a0:	41c00e33          	neg	t3,t3
aaaac2a4:	00175713          	srli	a4,a4,0x1
aaaac2a8:	00fe7e33          	and	t3,t3,a5
aaaac2ac:	00ee4e33          	xor	t3,t3,a4
aaaac2b0:	010e1e13          	slli	t3,t3,0x10
aaaac2b4:	010e5e13          	srli	t3,t3,0x10
aaaac2b8:	01c34733          	xor	a4,t1,t3
aaaac2bc:	00177713          	andi	a4,a4,1
aaaac2c0:	40e00733          	neg	a4,a4
aaaac2c4:	00f77733          	and	a4,a4,a5
aaaac2c8:	001e5e13          	srli	t3,t3,0x1
aaaac2cc:	01c74733          	xor	a4,a4,t3
aaaac2d0:	01071713          	slli	a4,a4,0x10
aaaac2d4:	01075713          	srli	a4,a4,0x10
aaaac2d8:	00e64633          	xor	a2,a2,a4
aaaac2dc:	00167613          	andi	a2,a2,1
aaaac2e0:	40c00633          	neg	a2,a2
aaaac2e4:	00175713          	srli	a4,a4,0x1
aaaac2e8:	00f67633          	and	a2,a2,a5
aaaac2ec:	00e64633          	xor	a2,a2,a4
aaaac2f0:	01061613          	slli	a2,a2,0x10
aaaac2f4:	01065613          	srli	a2,a2,0x10
aaaac2f8:	00c6c733          	xor	a4,a3,a2
aaaac2fc:	00177713          	andi	a4,a4,1
aaaac300:	40e00733          	neg	a4,a4
aaaac304:	00f77733          	and	a4,a4,a5
aaaac308:	00165613          	srli	a2,a2,0x1
aaaac30c:	00c74733          	xor	a4,a4,a2
aaaac310:	01071713          	slli	a4,a4,0x10
aaaac314:	01075713          	srli	a4,a4,0x10
aaaac318:	00e8c9b3          	xor	s3,a7,a4
aaaac31c:	0019f993          	andi	s3,s3,1
aaaac320:	413009b3          	neg	s3,s3
aaaac324:	00f9f9b3          	and	s3,s3,a5
aaaac328:	00175713          	srli	a4,a4,0x1
aaaac32c:	00e9c9b3          	xor	s3,s3,a4
aaaac330:	01099993          	slli	s3,s3,0x10
aaaac334:	00458593          	addi	a1,a1,4
aaaac338:	00450513          	addi	a0,a0,4
aaaac33c:	0109d993          	srli	s3,s3,0x10
aaaac340:	ed459c63          	bne	a1,s4,aaaaba18 <calc_func+0x4e8>
aaaac344:	03e4d783          	lhu	a5,62(s1)
aaaac348:	00079463          	bnez	a5,aaaac350 <calc_func+0xe20>
aaaac34c:	03349f23          	sh	s3,62(s1)
aaaac350:	01099513          	slli	a0,s3,0x10
aaaac354:	00098313          	mv	t1,s3
aaaac358:	07812a03          	lw	s4,120(sp)
aaaac35c:	07412a83          	lw	s5,116(sp)
aaaac360:	07012b03          	lw	s6,112(sp)
aaaac364:	06c12b83          	lw	s7,108(sp)
aaaac368:	06812c03          	lw	s8,104(sp)
aaaac36c:	06412c83          	lw	s9,100(sp)
aaaac370:	06012d03          	lw	s10,96(sp)
aaaac374:	05c12d83          	lw	s11,92(sp)
aaaac378:	41055513          	srai	a0,a0,0x10
aaaac37c:	00080993          	mv	s3,a6
aaaac380:	aacff06f          	j	aaaab62c <calc_func+0xfc>
aaaac384:	0ff7f613          	zext.b	a2,a5
aaaac388:	00167693          	andi	a3,a2,1
aaaac38c:	0000a737          	lui	a4,0xa
aaaac390:	40d006b3          	neg	a3,a3
aaaac394:	00170713          	addi	a4,a4,1 # a001 <_start-0xaaa9ffff>
aaaac398:	00d77733          	and	a4,a4,a3
aaaac39c:	00165693          	srli	a3,a2,0x1
aaaac3a0:	00e6c6b3          	xor	a3,a3,a4
aaaac3a4:	0016f693          	andi	a3,a3,1
aaaac3a8:	ffffa5b7          	lui	a1,0xffffa
aaaac3ac:	00158593          	addi	a1,a1,1 # ffffa001 <_stack_top+0xfffa001>
aaaac3b0:	40d006b3          	neg	a3,a3
aaaac3b4:	00175713          	srli	a4,a4,0x1
aaaac3b8:	00b6f6b3          	and	a3,a3,a1
aaaac3bc:	00e6c6b3          	xor	a3,a3,a4
aaaac3c0:	01069693          	slli	a3,a3,0x10
aaaac3c4:	0106d693          	srli	a3,a3,0x10
aaaac3c8:	00265713          	srli	a4,a2,0x2
aaaac3cc:	00d74733          	xor	a4,a4,a3
aaaac3d0:	00177713          	andi	a4,a4,1
aaaac3d4:	40e00733          	neg	a4,a4
aaaac3d8:	0016d693          	srli	a3,a3,0x1
aaaac3dc:	00b77733          	and	a4,a4,a1
aaaac3e0:	00d74733          	xor	a4,a4,a3
aaaac3e4:	01079793          	slli	a5,a5,0x10
aaaac3e8:	0107d793          	srli	a5,a5,0x10
aaaac3ec:	01071713          	slli	a4,a4,0x10
aaaac3f0:	0087d793          	srli	a5,a5,0x8
aaaac3f4:	01075713          	srli	a4,a4,0x10
aaaac3f8:	00365693          	srli	a3,a2,0x3
aaaac3fc:	00e6c5b3          	xor	a1,a3,a4
aaaac400:	0015f593          	andi	a1,a1,1
aaaac404:	ffffa637          	lui	a2,0xffffa
aaaac408:	00160613          	addi	a2,a2,1 # ffffa001 <_stack_top+0xfffa001>
aaaac40c:	40b005b3          	neg	a1,a1
aaaac410:	00175713          	srli	a4,a4,0x1
aaaac414:	00c5f5b3          	and	a1,a1,a2
aaaac418:	00e5c5b3          	xor	a1,a1,a4
aaaac41c:	01059593          	slli	a1,a1,0x10
aaaac420:	0105d593          	srli	a1,a1,0x10
aaaac424:	0016d713          	srli	a4,a3,0x1
aaaac428:	00b74733          	xor	a4,a4,a1
aaaac42c:	00177713          	andi	a4,a4,1
aaaac430:	40e00733          	neg	a4,a4
aaaac434:	0015d593          	srli	a1,a1,0x1
aaaac438:	00c77733          	and	a4,a4,a2
aaaac43c:	00b74733          	xor	a4,a4,a1
aaaac440:	01071713          	slli	a4,a4,0x10
aaaac444:	0026d813          	srli	a6,a3,0x2
aaaac448:	01075713          	srli	a4,a4,0x10
aaaac44c:	00e84833          	xor	a6,a6,a4
aaaac450:	00187813          	andi	a6,a6,1
aaaac454:	41000833          	neg	a6,a6
aaaac458:	00175713          	srli	a4,a4,0x1
aaaac45c:	00c87833          	and	a6,a6,a2
aaaac460:	00e84833          	xor	a6,a6,a4
aaaac464:	01081813          	slli	a6,a6,0x10
aaaac468:	0036d593          	srli	a1,a3,0x3
aaaac46c:	01085813          	srli	a6,a6,0x10
aaaac470:	0105c5b3          	xor	a1,a1,a6
aaaac474:	0015f593          	andi	a1,a1,1
aaaac478:	40b005b3          	neg	a1,a1
aaaac47c:	00185813          	srli	a6,a6,0x1
aaaac480:	00c5f5b3          	and	a1,a1,a2
aaaac484:	0105c5b3          	xor	a1,a1,a6
aaaac488:	01059593          	slli	a1,a1,0x10
aaaac48c:	0105d593          	srli	a1,a1,0x10
aaaac490:	0046d693          	srli	a3,a3,0x4
aaaac494:	00b6c6b3          	xor	a3,a3,a1
aaaac498:	0016f693          	andi	a3,a3,1
aaaac49c:	40d006b3          	neg	a3,a3
aaaac4a0:	0015d593          	srli	a1,a1,0x1
aaaac4a4:	00c6f6b3          	and	a3,a3,a2
aaaac4a8:	00b6c6b3          	xor	a3,a3,a1
aaaac4ac:	01069693          	slli	a3,a3,0x10
aaaac4b0:	0106d693          	srli	a3,a3,0x10
aaaac4b4:	00d7c5b3          	xor	a1,a5,a3
aaaac4b8:	0015f593          	andi	a1,a1,1
aaaac4bc:	40b005b3          	neg	a1,a1
aaaac4c0:	00c5f5b3          	and	a1,a1,a2
aaaac4c4:	0016d693          	srli	a3,a3,0x1
aaaac4c8:	00d5c6b3          	xor	a3,a1,a3
aaaac4cc:	01069693          	slli	a3,a3,0x10
aaaac4d0:	0017d713          	srli	a4,a5,0x1
aaaac4d4:	0106d693          	srli	a3,a3,0x10
aaaac4d8:	00d74733          	xor	a4,a4,a3
aaaac4dc:	00177713          	andi	a4,a4,1
aaaac4e0:	40e00733          	neg	a4,a4
aaaac4e4:	0016d693          	srli	a3,a3,0x1
aaaac4e8:	00c77733          	and	a4,a4,a2
aaaac4ec:	00d74733          	xor	a4,a4,a3
aaaac4f0:	01071713          	slli	a4,a4,0x10
aaaac4f4:	0027d893          	srli	a7,a5,0x2
aaaac4f8:	01075713          	srli	a4,a4,0x10
aaaac4fc:	00e8c8b3          	xor	a7,a7,a4
aaaac500:	0018f893          	andi	a7,a7,1
aaaac504:	411008b3          	neg	a7,a7
aaaac508:	00175713          	srli	a4,a4,0x1
aaaac50c:	00c8f8b3          	and	a7,a7,a2
aaaac510:	00e8c8b3          	xor	a7,a7,a4
aaaac514:	01089893          	slli	a7,a7,0x10
aaaac518:	0037d813          	srli	a6,a5,0x3
aaaac51c:	0108d893          	srli	a7,a7,0x10
aaaac520:	01184833          	xor	a6,a6,a7
aaaac524:	00187813          	andi	a6,a6,1
aaaac528:	41000833          	neg	a6,a6
aaaac52c:	00c87833          	and	a6,a6,a2
aaaac530:	0018d893          	srli	a7,a7,0x1
aaaac534:	01184833          	xor	a6,a6,a7
aaaac538:	01081813          	slli	a6,a6,0x10
aaaac53c:	0047d593          	srli	a1,a5,0x4
aaaac540:	01085813          	srli	a6,a6,0x10
aaaac544:	0105c5b3          	xor	a1,a1,a6
aaaac548:	0015f593          	andi	a1,a1,1
aaaac54c:	40b005b3          	neg	a1,a1
aaaac550:	00c5f5b3          	and	a1,a1,a2
aaaac554:	00185813          	srli	a6,a6,0x1
aaaac558:	0105c5b3          	xor	a1,a1,a6
aaaac55c:	01059593          	slli	a1,a1,0x10
aaaac560:	0057d693          	srli	a3,a5,0x5
aaaac564:	0105d593          	srli	a1,a1,0x10
aaaac568:	00b6c6b3          	xor	a3,a3,a1
aaaac56c:	0016f693          	andi	a3,a3,1
aaaac570:	40d006b3          	neg	a3,a3
aaaac574:	00c6f6b3          	and	a3,a3,a2
aaaac578:	0015d593          	srli	a1,a1,0x1
aaaac57c:	00b6c6b3          	xor	a3,a3,a1
aaaac580:	01069693          	slli	a3,a3,0x10
aaaac584:	0067d713          	srli	a4,a5,0x6
aaaac588:	0106d693          	srli	a3,a3,0x10
aaaac58c:	00d74733          	xor	a4,a4,a3
aaaac590:	00177713          	andi	a4,a4,1
aaaac594:	40e00733          	neg	a4,a4
aaaac598:	00c77733          	and	a4,a4,a2
aaaac59c:	0016d693          	srli	a3,a3,0x1
aaaac5a0:	00d74733          	xor	a4,a4,a3
aaaac5a4:	01071713          	slli	a4,a4,0x10
aaaac5a8:	01075713          	srli	a4,a4,0x10
aaaac5ac:	0077d793          	srli	a5,a5,0x7
aaaac5b0:	00e7c7b3          	xor	a5,a5,a4
aaaac5b4:	0017f793          	andi	a5,a5,1
aaaac5b8:	40f007b3          	neg	a5,a5
aaaac5bc:	00c7f7b3          	and	a5,a5,a2
aaaac5c0:	00175713          	srli	a4,a4,0x1
aaaac5c4:	00e7c7b3          	xor	a5,a5,a4
aaaac5c8:	01079793          	slli	a5,a5,0x10
aaaac5cc:	0107d793          	srli	a5,a5,0x10
aaaac5d0:	5a0e86e3          	beqz	t4,aaaad37c <calc_func+0x1e4c>
aaaac5d4:	002e9f13          	slli	t5,t4,0x2
aaaac5d8:	001e9893          	slli	a7,t4,0x1
aaaac5dc:	007f0f33          	add	t5,t5,t2
aaaac5e0:	014888b3          	add	a7,a7,s4
aaaac5e4:	00038293          	mv	t0,t2
aaaac5e8:	00000a93          	li	s5,0
aaaac5ec:	001a9613          	slli	a2,s5,0x1
aaaac5f0:	00cf8633          	add	a2,t6,a2
aaaac5f4:	000a0713          	mv	a4,s4
aaaac5f8:	00000593          	li	a1,0
aaaac5fc:	00061683          	lh	a3,0(a2)
aaaac600:	00071803          	lh	a6,0(a4)
aaaac604:	00270713          	addi	a4,a4,2
aaaac608:	00260613          	addi	a2,a2,2
aaaac60c:	030686b3          	mul	a3,a3,a6
aaaac610:	00d585b3          	add	a1,a1,a3
aaaac614:	fee894e3          	bne	a7,a4,aaaac5fc <calc_func+0x10cc>
aaaac618:	00b2a023          	sw	a1,0(t0)
aaaac61c:	00428293          	addi	t0,t0,4
aaaac620:	01da8ab3          	add	s5,s5,t4
aaaac624:	fde294e3          	bne	t0,t5,aaaac5ec <calc_func+0x10bc>
aaaac628:	41d00833          	neg	a6,t4
aaaac62c:	00281b93          	slli	s7,a6,0x2
aaaac630:	00381b13          	slli	s6,a6,0x3
aaaac634:	00000593          	li	a1,0
aaaac638:	00000893          	li	a7,0
aaaac63c:	00000713          	li	a4,0
aaaac640:	00000293          	li	t0,0
aaaac644:	017f0ab3          	add	s5,t5,s7
aaaac648:	000a8613          	mv	a2,s5
aaaac64c:	0140006f          	j	aaaac660 <calc_func+0x1130>
aaaac650:	01069713          	slli	a4,a3,0x10
aaaac654:	00460613          	addi	a2,a2,4
aaaac658:	41075713          	srai	a4,a4,0x10
aaaac65c:	03e60e63          	beq	a2,t5,aaaac698 <calc_func+0x1168>
aaaac660:	00058813          	mv	a6,a1
aaaac664:	01071693          	slli	a3,a4,0x10
aaaac668:	00062583          	lw	a1,0(a2)
aaaac66c:	0106d693          	srli	a3,a3,0x10
aaaac670:	00a68713          	addi	a4,a3,10
aaaac674:	00b82833          	slt	a6,a6,a1
aaaac678:	01071713          	slli	a4,a4,0x10
aaaac67c:	00b888b3          	add	a7,a7,a1
aaaac680:	41075713          	srai	a4,a4,0x10
aaaac684:	010686b3          	add	a3,a3,a6
aaaac688:	fd1554e3          	bge	a0,a7,aaaac650 <calc_func+0x1120>
aaaac68c:	00460613          	addi	a2,a2,4
aaaac690:	00000893          	li	a7,0
aaaac694:	fde616e3          	bne	a2,t5,aaaac660 <calc_func+0x1130>
aaaac698:	00128293          	addi	t0,t0,1
aaaac69c:	416a8f33          	sub	t5,s5,s6
aaaac6a0:	fa5e92e3          	bne	t4,t0,aaaac644 <calc_func+0x1114>
aaaac6a4:	01071f13          	slli	t5,a4,0x10
aaaac6a8:	010f5f13          	srli	t5,t5,0x10
aaaac6ac:	0ff77713          	zext.b	a4,a4
aaaac6b0:	008f5f13          	srli	t5,t5,0x8
aaaac6b4:	00f74633          	xor	a2,a4,a5
aaaac6b8:	00167613          	andi	a2,a2,1
aaaac6bc:	ffffa6b7          	lui	a3,0xffffa
aaaac6c0:	00168693          	addi	a3,a3,1 # ffffa001 <_stack_top+0xfffa001>
aaaac6c4:	40c00633          	neg	a2,a2
aaaac6c8:	0017d593          	srli	a1,a5,0x1
aaaac6cc:	00d677b3          	and	a5,a2,a3
aaaac6d0:	00b7c7b3          	xor	a5,a5,a1
aaaac6d4:	01079793          	slli	a5,a5,0x10
aaaac6d8:	0107d793          	srli	a5,a5,0x10
aaaac6dc:	00175593          	srli	a1,a4,0x1
aaaac6e0:	00f5c5b3          	xor	a1,a1,a5
aaaac6e4:	0015f593          	andi	a1,a1,1
aaaac6e8:	40b005b3          	neg	a1,a1
aaaac6ec:	0017d793          	srli	a5,a5,0x1
aaaac6f0:	00d5f5b3          	and	a1,a1,a3
aaaac6f4:	00f5c5b3          	xor	a1,a1,a5
aaaac6f8:	01059593          	slli	a1,a1,0x10
aaaac6fc:	00275613          	srli	a2,a4,0x2
aaaac700:	0105d593          	srli	a1,a1,0x10
aaaac704:	00b64633          	xor	a2,a2,a1
aaaac708:	00167613          	andi	a2,a2,1
aaaac70c:	40c00633          	neg	a2,a2
aaaac710:	0015d593          	srli	a1,a1,0x1
aaaac714:	00d67633          	and	a2,a2,a3
aaaac718:	00b64633          	xor	a2,a2,a1
aaaac71c:	01061613          	slli	a2,a2,0x10
aaaac720:	00375793          	srli	a5,a4,0x3
aaaac724:	01065613          	srli	a2,a2,0x10
aaaac728:	00c7c7b3          	xor	a5,a5,a2
aaaac72c:	0017f793          	andi	a5,a5,1
aaaac730:	40f007b3          	neg	a5,a5
aaaac734:	00165613          	srli	a2,a2,0x1
aaaac738:	00d7f7b3          	and	a5,a5,a3
aaaac73c:	00c7c7b3          	xor	a5,a5,a2
aaaac740:	01079793          	slli	a5,a5,0x10
aaaac744:	00475813          	srli	a6,a4,0x4
aaaac748:	0107d793          	srli	a5,a5,0x10
aaaac74c:	00f84833          	xor	a6,a6,a5
aaaac750:	00187813          	andi	a6,a6,1
aaaac754:	41000833          	neg	a6,a6
aaaac758:	0017d793          	srli	a5,a5,0x1
aaaac75c:	00d87833          	and	a6,a6,a3
aaaac760:	00f84833          	xor	a6,a6,a5
aaaac764:	01081813          	slli	a6,a6,0x10
aaaac768:	00575593          	srli	a1,a4,0x5
aaaac76c:	01085813          	srli	a6,a6,0x10
aaaac770:	0105c5b3          	xor	a1,a1,a6
aaaac774:	0015f593          	andi	a1,a1,1
aaaac778:	40b005b3          	neg	a1,a1
aaaac77c:	00185813          	srli	a6,a6,0x1
aaaac780:	00d5f5b3          	and	a1,a1,a3
aaaac784:	0105c5b3          	xor	a1,a1,a6
aaaac788:	01059593          	slli	a1,a1,0x10
aaaac78c:	00675613          	srli	a2,a4,0x6
aaaac790:	0105d593          	srli	a1,a1,0x10
aaaac794:	00b64633          	xor	a2,a2,a1
aaaac798:	00167613          	andi	a2,a2,1
aaaac79c:	40c00633          	neg	a2,a2
aaaac7a0:	0015d593          	srli	a1,a1,0x1
aaaac7a4:	00d67633          	and	a2,a2,a3
aaaac7a8:	00b64633          	xor	a2,a2,a1
aaaac7ac:	01061613          	slli	a2,a2,0x10
aaaac7b0:	00775793          	srli	a5,a4,0x7
aaaac7b4:	01065613          	srli	a2,a2,0x10
aaaac7b8:	00c7c7b3          	xor	a5,a5,a2
aaaac7bc:	0017f793          	andi	a5,a5,1
aaaac7c0:	40f007b3          	neg	a5,a5
aaaac7c4:	00165613          	srli	a2,a2,0x1
aaaac7c8:	00d7f7b3          	and	a5,a5,a3
aaaac7cc:	00c7c7b3          	xor	a5,a5,a2
aaaac7d0:	01079793          	slli	a5,a5,0x10
aaaac7d4:	0107d793          	srli	a5,a5,0x10
aaaac7d8:	00ff4633          	xor	a2,t5,a5
aaaac7dc:	00167613          	andi	a2,a2,1
aaaac7e0:	40c00633          	neg	a2,a2
aaaac7e4:	00d67633          	and	a2,a2,a3
aaaac7e8:	0017d793          	srli	a5,a5,0x1
aaaac7ec:	00f647b3          	xor	a5,a2,a5
aaaac7f0:	01079793          	slli	a5,a5,0x10
aaaac7f4:	001f5713          	srli	a4,t5,0x1
aaaac7f8:	0107d793          	srli	a5,a5,0x10
aaaac7fc:	00f74733          	xor	a4,a4,a5
aaaac800:	00177713          	andi	a4,a4,1
aaaac804:	40e00733          	neg	a4,a4
aaaac808:	0017d793          	srli	a5,a5,0x1
aaaac80c:	00d77733          	and	a4,a4,a3
aaaac810:	00f74733          	xor	a4,a4,a5
aaaac814:	01071713          	slli	a4,a4,0x10
aaaac818:	002f5893          	srli	a7,t5,0x2
aaaac81c:	01075713          	srli	a4,a4,0x10
aaaac820:	00e8c8b3          	xor	a7,a7,a4
aaaac824:	0018f893          	andi	a7,a7,1
aaaac828:	411008b3          	neg	a7,a7
aaaac82c:	00175713          	srli	a4,a4,0x1
aaaac830:	00d8f8b3          	and	a7,a7,a3
aaaac834:	00e8c8b3          	xor	a7,a7,a4
aaaac838:	01089893          	slli	a7,a7,0x10
aaaac83c:	003f5813          	srli	a6,t5,0x3
aaaac840:	0108d893          	srli	a7,a7,0x10
aaaac844:	01184833          	xor	a6,a6,a7
aaaac848:	00187813          	andi	a6,a6,1
aaaac84c:	41000833          	neg	a6,a6
aaaac850:	00d87833          	and	a6,a6,a3
aaaac854:	0018d893          	srli	a7,a7,0x1
aaaac858:	01184833          	xor	a6,a6,a7
aaaac85c:	01081813          	slli	a6,a6,0x10
aaaac860:	004f5593          	srli	a1,t5,0x4
aaaac864:	01085813          	srli	a6,a6,0x10
aaaac868:	0105c5b3          	xor	a1,a1,a6
aaaac86c:	0015f593          	andi	a1,a1,1
aaaac870:	40b005b3          	neg	a1,a1
aaaac874:	00d5f5b3          	and	a1,a1,a3
aaaac878:	00185813          	srli	a6,a6,0x1
aaaac87c:	0105c5b3          	xor	a1,a1,a6
aaaac880:	01059593          	slli	a1,a1,0x10
aaaac884:	005f5613          	srli	a2,t5,0x5
aaaac888:	0105d593          	srli	a1,a1,0x10
aaaac88c:	00b64633          	xor	a2,a2,a1
aaaac890:	00167613          	andi	a2,a2,1
aaaac894:	40c00633          	neg	a2,a2
aaaac898:	00d67633          	and	a2,a2,a3
aaaac89c:	0015d593          	srli	a1,a1,0x1
aaaac8a0:	00b64633          	xor	a2,a2,a1
aaaac8a4:	01061613          	slli	a2,a2,0x10
aaaac8a8:	006f5713          	srli	a4,t5,0x6
aaaac8ac:	01065613          	srli	a2,a2,0x10
aaaac8b0:	00c74733          	xor	a4,a4,a2
aaaac8b4:	00177713          	andi	a4,a4,1
aaaac8b8:	40e00733          	neg	a4,a4
aaaac8bc:	00d77733          	and	a4,a4,a3
aaaac8c0:	00165613          	srli	a2,a2,0x1
aaaac8c4:	00c74733          	xor	a4,a4,a2
aaaac8c8:	01071713          	slli	a4,a4,0x10
aaaac8cc:	007f5793          	srli	a5,t5,0x7
aaaac8d0:	01075713          	srli	a4,a4,0x10
aaaac8d4:	00e7c2b3          	xor	t0,a5,a4
aaaac8d8:	0012f293          	andi	t0,t0,1
aaaac8dc:	405002b3          	neg	t0,t0
aaaac8e0:	00d2f2b3          	and	t0,t0,a3
aaaac8e4:	00175713          	srli	a4,a4,0x1
aaaac8e8:	00e2c2b3          	xor	t0,t0,a4
aaaac8ec:	01029293          	slli	t0,t0,0x10
aaaac8f0:	0102d293          	srli	t0,t0,0x10
aaaac8f4:	00000f13          	li	t5,0
aaaac8f8:	00000793          	li	a5,0
aaaac8fc:	0a0e8063          	beqz	t4,aaaac99c <calc_func+0x146c>
aaaac900:	001e9813          	slli	a6,t4,0x1
aaaac904:	07912223          	sw	s9,100(sp)
aaaac908:	010f88b3          	add	a7,t6,a6
aaaac90c:	000f8b93          	mv	s7,t6
aaaac910:	00000c13          	li	s8,0
aaaac914:	00000c93          	li	s9,0
aaaac918:	002c1a93          	slli	s5,s8,0x2
aaaac91c:	007a8ab3          	add	s5,s5,t2
aaaac920:	000a0b13          	mv	s6,s4
aaaac924:	00000f13          	li	t5,0
aaaac928:	000b0693          	mv	a3,s6
aaaac92c:	000b8793          	mv	a5,s7
aaaac930:	00000613          	li	a2,0
aaaac934:	00079703          	lh	a4,0(a5)
aaaac938:	00069583          	lh	a1,0(a3)
aaaac93c:	00278793          	addi	a5,a5,2
aaaac940:	010686b3          	add	a3,a3,a6
aaaac944:	02b70733          	mul	a4,a4,a1
aaaac948:	00e60633          	add	a2,a2,a4
aaaac94c:	ff1794e3          	bne	a5,a7,aaaac934 <calc_func+0x1404>
aaaac950:	00caa023          	sw	a2,0(s5)
aaaac954:	001f0713          	addi	a4,t5,1
aaaac958:	004a8a93          	addi	s5,s5,4
aaaac95c:	002b0b13          	addi	s6,s6,2
aaaac960:	00ee8663          	beq	t4,a4,aaaac96c <calc_func+0x143c>
aaaac964:	00070f13          	mv	t5,a4
aaaac968:	fc1ff06f          	j	aaaac928 <calc_func+0x13f8>
aaaac96c:	010788b3          	add	a7,a5,a6
aaaac970:	010b8bb3          	add	s7,s7,a6
aaaac974:	01dc0c33          	add	s8,s8,t4
aaaac978:	001c8793          	addi	a5,s9,1
aaaac97c:	0dec8ee3          	beq	s9,t5,aaaad258 <calc_func+0x1d28>
aaaac980:	00078c93          	mv	s9,a5
aaaac984:	f95ff06f          	j	aaaac918 <calc_func+0x13e8>
aaaac988:	01079f13          	slli	t5,a5,0x10
aaaac98c:	06412c83          	lw	s9,100(sp)
aaaac990:	010f5f13          	srli	t5,t5,0x10
aaaac994:	0ff7f793          	zext.b	a5,a5
aaaac998:	008f5f13          	srli	t5,t5,0x8
aaaac99c:	0057c633          	xor	a2,a5,t0
aaaac9a0:	00167613          	andi	a2,a2,1
aaaac9a4:	ffffa737          	lui	a4,0xffffa
aaaac9a8:	00170713          	addi	a4,a4,1 # ffffa001 <_stack_top+0xfffa001>
aaaac9ac:	40c00633          	neg	a2,a2
aaaac9b0:	0012d293          	srli	t0,t0,0x1
aaaac9b4:	00e67633          	and	a2,a2,a4
aaaac9b8:	00564633          	xor	a2,a2,t0
aaaac9bc:	01061613          	slli	a2,a2,0x10
aaaac9c0:	01065613          	srli	a2,a2,0x10
aaaac9c4:	0017d693          	srli	a3,a5,0x1
aaaac9c8:	00c6c6b3          	xor	a3,a3,a2
aaaac9cc:	0016f693          	andi	a3,a3,1
aaaac9d0:	40d006b3          	neg	a3,a3
aaaac9d4:	00165613          	srli	a2,a2,0x1
aaaac9d8:	00e6f6b3          	and	a3,a3,a4
aaaac9dc:	00c6c6b3          	xor	a3,a3,a2
aaaac9e0:	01069693          	slli	a3,a3,0x10
aaaac9e4:	0027d593          	srli	a1,a5,0x2
aaaac9e8:	0106d693          	srli	a3,a3,0x10
aaaac9ec:	00d5c5b3          	xor	a1,a1,a3
aaaac9f0:	0015f593          	andi	a1,a1,1
aaaac9f4:	40b005b3          	neg	a1,a1
aaaac9f8:	0016d693          	srli	a3,a3,0x1
aaaac9fc:	00e5f5b3          	and	a1,a1,a4
aaaaca00:	00d5c5b3          	xor	a1,a1,a3
aaaaca04:	01059593          	slli	a1,a1,0x10
aaaaca08:	0037d613          	srli	a2,a5,0x3
aaaaca0c:	0105d593          	srli	a1,a1,0x10
aaaaca10:	00b64633          	xor	a2,a2,a1
aaaaca14:	00167613          	andi	a2,a2,1
aaaaca18:	40c00633          	neg	a2,a2
aaaaca1c:	0015d593          	srli	a1,a1,0x1
aaaaca20:	00e67633          	and	a2,a2,a4
aaaaca24:	00b64633          	xor	a2,a2,a1
aaaaca28:	01061613          	slli	a2,a2,0x10
aaaaca2c:	0047d693          	srli	a3,a5,0x4
aaaaca30:	01065613          	srli	a2,a2,0x10
aaaaca34:	00c6c6b3          	xor	a3,a3,a2
aaaaca38:	0016f693          	andi	a3,a3,1
aaaaca3c:	40d006b3          	neg	a3,a3
aaaaca40:	00165613          	srli	a2,a2,0x1
aaaaca44:	00e6f6b3          	and	a3,a3,a4
aaaaca48:	00c6c6b3          	xor	a3,a3,a2
aaaaca4c:	01069693          	slli	a3,a3,0x10
aaaaca50:	0057d593          	srli	a1,a5,0x5
aaaaca54:	0106d693          	srli	a3,a3,0x10
aaaaca58:	00d5c5b3          	xor	a1,a1,a3
aaaaca5c:	0015f593          	andi	a1,a1,1
aaaaca60:	40b005b3          	neg	a1,a1
aaaaca64:	0016d693          	srli	a3,a3,0x1
aaaaca68:	00e5f5b3          	and	a1,a1,a4
aaaaca6c:	00d5c5b3          	xor	a1,a1,a3
aaaaca70:	01059593          	slli	a1,a1,0x10
aaaaca74:	0067d613          	srli	a2,a5,0x6
aaaaca78:	0105d593          	srli	a1,a1,0x10
aaaaca7c:	00b64633          	xor	a2,a2,a1
aaaaca80:	00167613          	andi	a2,a2,1
aaaaca84:	40c00633          	neg	a2,a2
aaaaca88:	0015d593          	srli	a1,a1,0x1
aaaaca8c:	00e67633          	and	a2,a2,a4
aaaaca90:	00b64633          	xor	a2,a2,a1
aaaaca94:	01061613          	slli	a2,a2,0x10
aaaaca98:	01065613          	srli	a2,a2,0x10
aaaaca9c:	0077d793          	srli	a5,a5,0x7
aaaacaa0:	00c7c7b3          	xor	a5,a5,a2
aaaacaa4:	0017f793          	andi	a5,a5,1
aaaacaa8:	40f007b3          	neg	a5,a5
aaaacaac:	00165613          	srli	a2,a2,0x1
aaaacab0:	00e7f7b3          	and	a5,a5,a4
aaaacab4:	00c7c7b3          	xor	a5,a5,a2
aaaacab8:	01079793          	slli	a5,a5,0x10
aaaacabc:	0107d793          	srli	a5,a5,0x10
aaaacac0:	00ff4633          	xor	a2,t5,a5
aaaacac4:	00167613          	andi	a2,a2,1
aaaacac8:	40c00633          	neg	a2,a2
aaaacacc:	00e67633          	and	a2,a2,a4
aaaacad0:	0017d793          	srli	a5,a5,0x1
aaaacad4:	00f647b3          	xor	a5,a2,a5
aaaacad8:	01079793          	slli	a5,a5,0x10
aaaacadc:	0107d793          	srli	a5,a5,0x10
aaaacae0:	001f5693          	srli	a3,t5,0x1
aaaacae4:	00f6c6b3          	xor	a3,a3,a5
aaaacae8:	0016f693          	andi	a3,a3,1
aaaacaec:	40d006b3          	neg	a3,a3
aaaacaf0:	0017d793          	srli	a5,a5,0x1
aaaacaf4:	00e6f6b3          	and	a3,a3,a4
aaaacaf8:	00f6c6b3          	xor	a3,a3,a5
aaaacafc:	01069693          	slli	a3,a3,0x10
aaaacb00:	0106d693          	srli	a3,a3,0x10
aaaacb04:	002f5893          	srli	a7,t5,0x2
aaaacb08:	00d8c8b3          	xor	a7,a7,a3
aaaacb0c:	0018f893          	andi	a7,a7,1
aaaacb10:	411008b3          	neg	a7,a7
aaaacb14:	0016d693          	srli	a3,a3,0x1
aaaacb18:	00e8f8b3          	and	a7,a7,a4
aaaacb1c:	00d8c8b3          	xor	a7,a7,a3
aaaacb20:	01089893          	slli	a7,a7,0x10
aaaacb24:	0108d893          	srli	a7,a7,0x10
aaaacb28:	003f5813          	srli	a6,t5,0x3
aaaacb2c:	01184833          	xor	a6,a6,a7
aaaacb30:	00187813          	andi	a6,a6,1
aaaacb34:	41000833          	neg	a6,a6
aaaacb38:	00e87833          	and	a6,a6,a4
aaaacb3c:	0018d893          	srli	a7,a7,0x1
aaaacb40:	01184833          	xor	a6,a6,a7
aaaacb44:	01081813          	slli	a6,a6,0x10
aaaacb48:	01085813          	srli	a6,a6,0x10
aaaacb4c:	004f5593          	srli	a1,t5,0x4
aaaacb50:	0105c5b3          	xor	a1,a1,a6
aaaacb54:	0015f593          	andi	a1,a1,1
aaaacb58:	40b005b3          	neg	a1,a1
aaaacb5c:	00e5f5b3          	and	a1,a1,a4
aaaacb60:	00185813          	srli	a6,a6,0x1
aaaacb64:	0105c5b3          	xor	a1,a1,a6
aaaacb68:	01059593          	slli	a1,a1,0x10
aaaacb6c:	0105d593          	srli	a1,a1,0x10
aaaacb70:	005f5613          	srli	a2,t5,0x5
aaaacb74:	00b64633          	xor	a2,a2,a1
aaaacb78:	00167613          	andi	a2,a2,1
aaaacb7c:	40c00633          	neg	a2,a2
aaaacb80:	00e67633          	and	a2,a2,a4
aaaacb84:	0015d593          	srli	a1,a1,0x1
aaaacb88:	00b64633          	xor	a2,a2,a1
aaaacb8c:	01061613          	slli	a2,a2,0x10
aaaacb90:	01065613          	srli	a2,a2,0x10
aaaacb94:	006f5693          	srli	a3,t5,0x6
aaaacb98:	00c6c6b3          	xor	a3,a3,a2
aaaacb9c:	0016f693          	andi	a3,a3,1
aaaacba0:	40d006b3          	neg	a3,a3
aaaacba4:	00e6f6b3          	and	a3,a3,a4
aaaacba8:	00165613          	srli	a2,a2,0x1
aaaacbac:	00c6c6b3          	xor	a3,a3,a2
aaaacbb0:	01069693          	slli	a3,a3,0x10
aaaacbb4:	007f5793          	srli	a5,t5,0x7
aaaacbb8:	0106d693          	srli	a3,a3,0x10
aaaacbbc:	00d7cbb3          	xor	s7,a5,a3
aaaacbc0:	001bfb93          	andi	s7,s7,1
aaaacbc4:	41700bb3          	neg	s7,s7
aaaacbc8:	00ebfbb3          	and	s7,s7,a4
aaaacbcc:	0016d693          	srli	a3,a3,0x1
aaaacbd0:	00dbcbb3          	xor	s7,s7,a3
aaaacbd4:	010b9b93          	slli	s7,s7,0x10
aaaacbd8:	010bdb93          	srli	s7,s7,0x10
aaaacbdc:	00000793          	li	a5,0
aaaacbe0:	0a0e8663          	beqz	t4,aaaacc8c <calc_func+0x175c>
aaaacbe4:	001e9813          	slli	a6,t4,0x1
aaaacbe8:	010f85b3          	add	a1,t6,a6
aaaacbec:	000f8293          	mv	t0,t6
aaaacbf0:	00000a93          	li	s5,0
aaaacbf4:	00000b13          	li	s6,0
aaaacbf8:	002a9893          	slli	a7,s5,0x2
aaaacbfc:	007888b3          	add	a7,a7,t2
aaaacc00:	000a0e13          	mv	t3,s4
aaaacc04:	00000f13          	li	t5,0
aaaacc08:	000e0693          	mv	a3,t3
aaaacc0c:	00028713          	mv	a4,t0
aaaacc10:	00000613          	li	a2,0
aaaacc14:	00069c03          	lh	s8,0(a3)
aaaacc18:	00071783          	lh	a5,0(a4)
aaaacc1c:	00270713          	addi	a4,a4,2
aaaacc20:	010686b3          	add	a3,a3,a6
aaaacc24:	038787b3          	mul	a5,a5,s8
aaaacc28:	4027dc13          	srai	s8,a5,0x2
aaaacc2c:	4057d793          	srai	a5,a5,0x5
aaaacc30:	00fc7c13          	andi	s8,s8,15
aaaacc34:	07f7f793          	andi	a5,a5,127
aaaacc38:	02fc07b3          	mul	a5,s8,a5
aaaacc3c:	00f60633          	add	a2,a2,a5
aaaacc40:	fcb71ae3          	bne	a4,a1,aaaacc14 <calc_func+0x16e4>
aaaacc44:	00c8a023          	sw	a2,0(a7)
aaaacc48:	001f0793          	addi	a5,t5,1
aaaacc4c:	00488893          	addi	a7,a7,4
aaaacc50:	002e0e13          	addi	t3,t3,2
aaaacc54:	00fe8663          	beq	t4,a5,aaaacc60 <calc_func+0x1730>
aaaacc58:	00078f13          	mv	t5,a5
aaaacc5c:	fadff06f          	j	aaaacc08 <calc_func+0x16d8>
aaaacc60:	010282b3          	add	t0,t0,a6
aaaacc64:	01da8ab3          	add	s5,s5,t4
aaaacc68:	010705b3          	add	a1,a4,a6
aaaacc6c:	001b0793          	addi	a5,s6,1
aaaacc70:	51eb0a63          	beq	s6,t5,aaaad184 <calc_func+0x1c54>
aaaacc74:	00078b13          	mv	s6,a5
aaaacc78:	f81ff06f          	j	aaaacbf8 <calc_func+0x16c8>
aaaacc7c:	01079713          	slli	a4,a5,0x10
aaaacc80:	01075713          	srli	a4,a4,0x10
aaaacc84:	0ff7fe13          	zext.b	t3,a5
aaaacc88:	00875793          	srli	a5,a4,0x8
aaaacc8c:	017e45b3          	xor	a1,t3,s7
aaaacc90:	0015f593          	andi	a1,a1,1
aaaacc94:	ffffa737          	lui	a4,0xffffa
aaaacc98:	00170713          	addi	a4,a4,1 # ffffa001 <_stack_top+0xfffa001>
aaaacc9c:	40b005b3          	neg	a1,a1
aaaacca0:	001bdb93          	srli	s7,s7,0x1
aaaacca4:	00e5f5b3          	and	a1,a1,a4
aaaacca8:	0175c5b3          	xor	a1,a1,s7
aaaaccac:	01059593          	slli	a1,a1,0x10
aaaaccb0:	0105d593          	srli	a1,a1,0x10
aaaaccb4:	001e5613          	srli	a2,t3,0x1
aaaaccb8:	00b64633          	xor	a2,a2,a1
aaaaccbc:	00167613          	andi	a2,a2,1
aaaaccc0:	40c00633          	neg	a2,a2
aaaaccc4:	0015d593          	srli	a1,a1,0x1
aaaaccc8:	00e67633          	and	a2,a2,a4
aaaacccc:	00b64633          	xor	a2,a2,a1
aaaaccd0:	01061613          	slli	a2,a2,0x10
aaaaccd4:	002e5693          	srli	a3,t3,0x2
aaaaccd8:	01065613          	srli	a2,a2,0x10
aaaaccdc:	00c6c6b3          	xor	a3,a3,a2
aaaacce0:	0016f693          	andi	a3,a3,1
aaaacce4:	40d006b3          	neg	a3,a3
aaaacce8:	00165613          	srli	a2,a2,0x1
aaaaccec:	00e6f6b3          	and	a3,a3,a4
aaaaccf0:	00c6c6b3          	xor	a3,a3,a2
aaaaccf4:	01069693          	slli	a3,a3,0x10
aaaaccf8:	003e5813          	srli	a6,t3,0x3
aaaaccfc:	0106d693          	srli	a3,a3,0x10
aaaacd00:	00d84833          	xor	a6,a6,a3
aaaacd04:	00187813          	andi	a6,a6,1
aaaacd08:	41000833          	neg	a6,a6
aaaacd0c:	0016d693          	srli	a3,a3,0x1
aaaacd10:	00e87833          	and	a6,a6,a4
aaaacd14:	00d84833          	xor	a6,a6,a3
aaaacd18:	01081813          	slli	a6,a6,0x10
aaaacd1c:	004e5513          	srli	a0,t3,0x4
aaaacd20:	01085813          	srli	a6,a6,0x10
aaaacd24:	01054533          	xor	a0,a0,a6
aaaacd28:	00157513          	andi	a0,a0,1
aaaacd2c:	40a00533          	neg	a0,a0
aaaacd30:	00185813          	srli	a6,a6,0x1
aaaacd34:	00e57533          	and	a0,a0,a4
aaaacd38:	01054533          	xor	a0,a0,a6
aaaacd3c:	01051513          	slli	a0,a0,0x10
aaaacd40:	005e5593          	srli	a1,t3,0x5
aaaacd44:	01055513          	srli	a0,a0,0x10
aaaacd48:	00a5c5b3          	xor	a1,a1,a0
aaaacd4c:	0015f593          	andi	a1,a1,1
aaaacd50:	40b005b3          	neg	a1,a1
aaaacd54:	00155513          	srli	a0,a0,0x1
aaaacd58:	00e5f5b3          	and	a1,a1,a4
aaaacd5c:	00a5c5b3          	xor	a1,a1,a0
aaaacd60:	01059593          	slli	a1,a1,0x10
aaaacd64:	006e5613          	srli	a2,t3,0x6
aaaacd68:	0105d593          	srli	a1,a1,0x10
aaaacd6c:	00b64633          	xor	a2,a2,a1
aaaacd70:	00167613          	andi	a2,a2,1
aaaacd74:	40c00633          	neg	a2,a2
aaaacd78:	0015d593          	srli	a1,a1,0x1
aaaacd7c:	00e67633          	and	a2,a2,a4
aaaacd80:	00b64633          	xor	a2,a2,a1
aaaacd84:	01061613          	slli	a2,a2,0x10
aaaacd88:	007e5693          	srli	a3,t3,0x7
aaaacd8c:	01065613          	srli	a2,a2,0x10
aaaacd90:	00c6c6b3          	xor	a3,a3,a2
aaaacd94:	0016f693          	andi	a3,a3,1
aaaacd98:	40d006b3          	neg	a3,a3
aaaacd9c:	00165613          	srli	a2,a2,0x1
aaaacda0:	00e6f6b3          	and	a3,a3,a4
aaaacda4:	00c6c6b3          	xor	a3,a3,a2
aaaacda8:	01069693          	slli	a3,a3,0x10
aaaacdac:	0106d693          	srli	a3,a3,0x10
aaaacdb0:	00d7ce33          	xor	t3,a5,a3
aaaacdb4:	001e7e13          	andi	t3,t3,1
aaaacdb8:	41c00e33          	neg	t3,t3
aaaacdbc:	0016d693          	srli	a3,a3,0x1
aaaacdc0:	00ee7e33          	and	t3,t3,a4
aaaacdc4:	00de4e33          	xor	t3,t3,a3
aaaacdc8:	010e1e13          	slli	t3,t3,0x10
aaaacdcc:	0017d893          	srli	a7,a5,0x1
aaaacdd0:	010e5e13          	srli	t3,t3,0x10
aaaacdd4:	01c8c8b3          	xor	a7,a7,t3
aaaacdd8:	0018f893          	andi	a7,a7,1
aaaacddc:	411008b3          	neg	a7,a7
aaaacde0:	00e8f8b3          	and	a7,a7,a4
aaaacde4:	001e5e13          	srli	t3,t3,0x1
aaaacde8:	01c8c8b3          	xor	a7,a7,t3
aaaacdec:	01089893          	slli	a7,a7,0x10
aaaacdf0:	0027d813          	srli	a6,a5,0x2
aaaacdf4:	0108d893          	srli	a7,a7,0x10
aaaacdf8:	01184833          	xor	a6,a6,a7
aaaacdfc:	00187813          	andi	a6,a6,1
aaaace00:	41000833          	neg	a6,a6
aaaace04:	00e87833          	and	a6,a6,a4
aaaace08:	0018d893          	srli	a7,a7,0x1
aaaace0c:	01184833          	xor	a6,a6,a7
aaaace10:	01081813          	slli	a6,a6,0x10
aaaace14:	0037d513          	srli	a0,a5,0x3
aaaace18:	01085813          	srli	a6,a6,0x10
aaaace1c:	01054533          	xor	a0,a0,a6
aaaace20:	00157513          	andi	a0,a0,1
aaaace24:	40a00533          	neg	a0,a0
aaaace28:	00e57533          	and	a0,a0,a4
aaaace2c:	00185813          	srli	a6,a6,0x1
aaaace30:	01054533          	xor	a0,a0,a6
aaaace34:	01051513          	slli	a0,a0,0x10
aaaace38:	0047d593          	srli	a1,a5,0x4
aaaace3c:	01055513          	srli	a0,a0,0x10
aaaace40:	00a5c5b3          	xor	a1,a1,a0
aaaace44:	0015f593          	andi	a1,a1,1
aaaace48:	40b005b3          	neg	a1,a1
aaaace4c:	00e5f5b3          	and	a1,a1,a4
aaaace50:	00155513          	srli	a0,a0,0x1
aaaace54:	00a5c5b3          	xor	a1,a1,a0
aaaace58:	01059593          	slli	a1,a1,0x10
aaaace5c:	0057d613          	srli	a2,a5,0x5
aaaace60:	0105d593          	srli	a1,a1,0x10
aaaace64:	00b64633          	xor	a2,a2,a1
aaaace68:	00167613          	andi	a2,a2,1
aaaace6c:	40c00633          	neg	a2,a2
aaaace70:	0015d593          	srli	a1,a1,0x1
aaaace74:	00e67633          	and	a2,a2,a4
aaaace78:	00b64633          	xor	a2,a2,a1
aaaace7c:	01061613          	slli	a2,a2,0x10
aaaace80:	0067d693          	srli	a3,a5,0x6
aaaace84:	01065613          	srli	a2,a2,0x10
aaaace88:	00c6c6b3          	xor	a3,a3,a2
aaaace8c:	0016f693          	andi	a3,a3,1
aaaace90:	40d006b3          	neg	a3,a3
aaaace94:	00e6f6b3          	and	a3,a3,a4
aaaace98:	00165613          	srli	a2,a2,0x1
aaaace9c:	00c6c6b3          	xor	a3,a3,a2
aaaacea0:	01069693          	slli	a3,a3,0x10
aaaacea4:	0106d693          	srli	a3,a3,0x10
aaaacea8:	0077d793          	srli	a5,a5,0x7
aaaaceac:	00d7c7b3          	xor	a5,a5,a3
aaaaceb0:	0017f793          	andi	a5,a5,1
aaaaceb4:	40f007b3          	neg	a5,a5
aaaaceb8:	00e7f7b3          	and	a5,a5,a4
aaaacebc:	0016d693          	srli	a3,a3,0x1
aaaacec0:	00d7c7b3          	xor	a5,a5,a3
aaaacec4:	01079593          	slli	a1,a5,0x10
aaaacec8:	0105d593          	srli	a1,a1,0x10
aaaacecc:	040e8063          	beqz	t4,aaaacf0c <calc_func+0x19dc>
aaaaced0:	001e9893          	slli	a7,t4,0x1
aaaaced4:	41d00833          	neg	a6,t4
aaaaced8:	011f8fb3          	add	t6,t6,a7
aaaacedc:	00281513          	slli	a0,a6,0x2
aaaacee0:	00000693          	li	a3,0
aaaacee4:	411f8633          	sub	a2,t6,a7
aaaacee8:	00060793          	mv	a5,a2
aaaaceec:	0007d703          	lhu	a4,0(a5)
aaaacef0:	00278793          	addi	a5,a5,2
aaaacef4:	40670733          	sub	a4,a4,t1
aaaacef8:	fee79f23          	sh	a4,-2(a5)
aaaacefc:	fff798e3          	bne	a5,t6,aaaaceec <calc_func+0x19bc>
aaaacf00:	00168693          	addi	a3,a3,1
aaaacf04:	40a60fb3          	sub	t6,a2,a0
aaaacf08:	fcde9ee3          	bne	t4,a3,aaaacee4 <calc_func+0x19b4>
aaaacf0c:	0ff5fe13          	zext.b	t3,a1
aaaacf10:	013e4633          	xor	a2,t3,s3
aaaacf14:	00167613          	andi	a2,a2,1
aaaacf18:	ffffa737          	lui	a4,0xffffa
aaaacf1c:	00170713          	addi	a4,a4,1 # ffffa001 <_stack_top+0xfffa001>
aaaacf20:	40c00633          	neg	a2,a2
aaaacf24:	0019d993          	srli	s3,s3,0x1
aaaacf28:	00e67633          	and	a2,a2,a4
aaaacf2c:	01364633          	xor	a2,a2,s3
aaaacf30:	01061613          	slli	a2,a2,0x10
aaaacf34:	01065613          	srli	a2,a2,0x10
aaaacf38:	001e5693          	srli	a3,t3,0x1
aaaacf3c:	00c6c6b3          	xor	a3,a3,a2
aaaacf40:	0016f693          	andi	a3,a3,1
aaaacf44:	40d006b3          	neg	a3,a3
aaaacf48:	00165613          	srli	a2,a2,0x1
aaaacf4c:	00e6f6b3          	and	a3,a3,a4
aaaacf50:	00c6c6b3          	xor	a3,a3,a2
aaaacf54:	01069693          	slli	a3,a3,0x10
aaaacf58:	002e5793          	srli	a5,t3,0x2
aaaacf5c:	0106d693          	srli	a3,a3,0x10
aaaacf60:	00d7c7b3          	xor	a5,a5,a3
aaaacf64:	0017f793          	andi	a5,a5,1
aaaacf68:	40f007b3          	neg	a5,a5
aaaacf6c:	0016d693          	srli	a3,a3,0x1
aaaacf70:	00e7f7b3          	and	a5,a5,a4
aaaacf74:	00d7c7b3          	xor	a5,a5,a3
aaaacf78:	01079793          	slli	a5,a5,0x10
aaaacf7c:	003e5813          	srli	a6,t3,0x3
aaaacf80:	0107d793          	srli	a5,a5,0x10
aaaacf84:	00f84833          	xor	a6,a6,a5
aaaacf88:	00187813          	andi	a6,a6,1
aaaacf8c:	41000833          	neg	a6,a6
aaaacf90:	0017d793          	srli	a5,a5,0x1
aaaacf94:	00e87833          	and	a6,a6,a4
aaaacf98:	00f84833          	xor	a6,a6,a5
aaaacf9c:	01081813          	slli	a6,a6,0x10
aaaacfa0:	004e5513          	srli	a0,t3,0x4
aaaacfa4:	01085813          	srli	a6,a6,0x10
aaaacfa8:	0085d793          	srli	a5,a1,0x8
aaaacfac:	010545b3          	xor	a1,a0,a6
aaaacfb0:	0015f593          	andi	a1,a1,1
aaaacfb4:	40b005b3          	neg	a1,a1
aaaacfb8:	00185813          	srli	a6,a6,0x1
aaaacfbc:	00e5f5b3          	and	a1,a1,a4
aaaacfc0:	0105c5b3          	xor	a1,a1,a6
aaaacfc4:	01059593          	slli	a1,a1,0x10
aaaacfc8:	005e5613          	srli	a2,t3,0x5
aaaacfcc:	0105d593          	srli	a1,a1,0x10
aaaacfd0:	00b64633          	xor	a2,a2,a1
aaaacfd4:	00167613          	andi	a2,a2,1
aaaacfd8:	40c00633          	neg	a2,a2
aaaacfdc:	0015d593          	srli	a1,a1,0x1
aaaacfe0:	00e67633          	and	a2,a2,a4
aaaacfe4:	00b64633          	xor	a2,a2,a1
aaaacfe8:	01061613          	slli	a2,a2,0x10
aaaacfec:	006e5693          	srli	a3,t3,0x6
aaaacff0:	01065613          	srli	a2,a2,0x10
aaaacff4:	00c6c5b3          	xor	a1,a3,a2
aaaacff8:	0015f593          	andi	a1,a1,1
aaaacffc:	40b005b3          	neg	a1,a1
aaaad000:	00165613          	srli	a2,a2,0x1
aaaad004:	00e5f5b3          	and	a1,a1,a4
aaaad008:	00c5c5b3          	xor	a1,a1,a2
aaaad00c:	01059593          	slli	a1,a1,0x10
aaaad010:	0105d593          	srli	a1,a1,0x10
aaaad014:	007e5e13          	srli	t3,t3,0x7
aaaad018:	00be4e33          	xor	t3,t3,a1
aaaad01c:	001e7e13          	andi	t3,t3,1
aaaad020:	41c00e33          	neg	t3,t3
aaaad024:	0015d593          	srli	a1,a1,0x1
aaaad028:	00ee7e33          	and	t3,t3,a4
aaaad02c:	00be4e33          	xor	t3,t3,a1
aaaad030:	010e1e13          	slli	t3,t3,0x10
aaaad034:	010e5e13          	srli	t3,t3,0x10
aaaad038:	0017d313          	srli	t1,a5,0x1
aaaad03c:	0027de93          	srli	t4,a5,0x2
aaaad040:	0037d893          	srli	a7,a5,0x3
aaaad044:	0047d813          	srli	a6,a5,0x4
aaaad048:	0057d613          	srli	a2,a5,0x5
aaaad04c:	0067d693          	srli	a3,a5,0x6
aaaad050:	0077d513          	srli	a0,a5,0x7
aaaad054:	01c7c7b3          	xor	a5,a5,t3
aaaad058:	0017f793          	andi	a5,a5,1
aaaad05c:	40f007b3          	neg	a5,a5
aaaad060:	00e7f7b3          	and	a5,a5,a4
aaaad064:	001e5e13          	srli	t3,t3,0x1
aaaad068:	01c7c7b3          	xor	a5,a5,t3
aaaad06c:	01079793          	slli	a5,a5,0x10
aaaad070:	0107d793          	srli	a5,a5,0x10
aaaad074:	00f34333          	xor	t1,t1,a5
aaaad078:	00137313          	andi	t1,t1,1
aaaad07c:	40600333          	neg	t1,t1
aaaad080:	0017d793          	srli	a5,a5,0x1
aaaad084:	00e37333          	and	t1,t1,a4
aaaad088:	00f34333          	xor	t1,t1,a5
aaaad08c:	01031313          	slli	t1,t1,0x10
aaaad090:	01035313          	srli	t1,t1,0x10
aaaad094:	006ec7b3          	xor	a5,t4,t1
aaaad098:	0017f793          	andi	a5,a5,1
aaaad09c:	40f007b3          	neg	a5,a5
aaaad0a0:	00135313          	srli	t1,t1,0x1
aaaad0a4:	00e7f7b3          	and	a5,a5,a4
aaaad0a8:	0067c7b3          	xor	a5,a5,t1
aaaad0ac:	01079793          	slli	a5,a5,0x10
aaaad0b0:	0107d793          	srli	a5,a5,0x10
aaaad0b4:	00f8c8b3          	xor	a7,a7,a5
aaaad0b8:	0018f893          	andi	a7,a7,1
aaaad0bc:	411008b3          	neg	a7,a7
aaaad0c0:	0017d793          	srli	a5,a5,0x1
aaaad0c4:	00e8f8b3          	and	a7,a7,a4
aaaad0c8:	00f8c8b3          	xor	a7,a7,a5
aaaad0cc:	01089893          	slli	a7,a7,0x10
aaaad0d0:	0108d893          	srli	a7,a7,0x10
aaaad0d4:	011847b3          	xor	a5,a6,a7
aaaad0d8:	0017f793          	andi	a5,a5,1
aaaad0dc:	40f007b3          	neg	a5,a5
aaaad0e0:	00e7f7b3          	and	a5,a5,a4
aaaad0e4:	0018d893          	srli	a7,a7,0x1
aaaad0e8:	0117c7b3          	xor	a5,a5,a7
aaaad0ec:	01079793          	slli	a5,a5,0x10
aaaad0f0:	0107d793          	srli	a5,a5,0x10
aaaad0f4:	00f64633          	xor	a2,a2,a5
aaaad0f8:	00167613          	andi	a2,a2,1
aaaad0fc:	40c00633          	neg	a2,a2
aaaad100:	0017d793          	srli	a5,a5,0x1
aaaad104:	00e67633          	and	a2,a2,a4
aaaad108:	00f64633          	xor	a2,a2,a5
aaaad10c:	01061613          	slli	a2,a2,0x10
aaaad110:	01065613          	srli	a2,a2,0x10
aaaad114:	00c6c7b3          	xor	a5,a3,a2
aaaad118:	0017f793          	andi	a5,a5,1
aaaad11c:	40f007b3          	neg	a5,a5
aaaad120:	00e7f7b3          	and	a5,a5,a4
aaaad124:	00165613          	srli	a2,a2,0x1
aaaad128:	00c7c7b3          	xor	a5,a5,a2
aaaad12c:	01079793          	slli	a5,a5,0x10
aaaad130:	0107d793          	srli	a5,a5,0x10
aaaad134:	00f54333          	xor	t1,a0,a5
aaaad138:	00137313          	andi	t1,t1,1
aaaad13c:	40600333          	neg	t1,t1
aaaad140:	00e37333          	and	t1,t1,a4
aaaad144:	0017d793          	srli	a5,a5,0x1
aaaad148:	03c4d583          	lhu	a1,60(s1)
aaaad14c:	00f34333          	xor	t1,t1,a5
aaaad150:	01031313          	slli	t1,t1,0x10
aaaad154:	0384d983          	lhu	s3,56(s1)
aaaad158:	01035313          	srli	t1,t1,0x10
aaaad15c:	00059463          	bnez	a1,aaaad164 <calc_func+0x1c34>
aaaad160:	02649e23          	sh	t1,60(s1)
aaaad164:	01031513          	slli	a0,t1,0x10
aaaad168:	07812a03          	lw	s4,120(sp)
aaaad16c:	07412a83          	lw	s5,116(sp)
aaaad170:	07012b03          	lw	s6,112(sp)
aaaad174:	06c12b83          	lw	s7,108(sp)
aaaad178:	06812c03          	lw	s8,104(sp)
aaaad17c:	41055513          	srai	a0,a0,0x10
aaaad180:	cacfe06f          	j	aaaab62c <calc_func+0xfc>
aaaad184:	41d00833          	neg	a6,t4
aaaad188:	002e9893          	slli	a7,t4,0x2
aaaad18c:	011388b3          	add	a7,t2,a7
aaaad190:	00281a13          	slli	s4,a6,0x2
aaaad194:	00381393          	slli	t2,a6,0x3
aaaad198:	00000613          	li	a2,0
aaaad19c:	00000813          	li	a6,0
aaaad1a0:	00000793          	li	a5,0
aaaad1a4:	00000e13          	li	t3,0
aaaad1a8:	011a02b3          	add	t0,s4,a7
aaaad1ac:	00028693          	mv	a3,t0
aaaad1b0:	0140006f          	j	aaaad1c4 <calc_func+0x1c94>
aaaad1b4:	01071793          	slli	a5,a4,0x10
aaaad1b8:	00468693          	addi	a3,a3,4
aaaad1bc:	4107d793          	srai	a5,a5,0x10
aaaad1c0:	03168e63          	beq	a3,a7,aaaad1fc <calc_func+0x1ccc>
aaaad1c4:	00060593          	mv	a1,a2
aaaad1c8:	01079713          	slli	a4,a5,0x10
aaaad1cc:	0006a603          	lw	a2,0(a3)
aaaad1d0:	01075713          	srli	a4,a4,0x10
aaaad1d4:	00a70793          	addi	a5,a4,10
aaaad1d8:	00c5a5b3          	slt	a1,a1,a2
aaaad1dc:	01079793          	slli	a5,a5,0x10
aaaad1e0:	00c80833          	add	a6,a6,a2
aaaad1e4:	4107d793          	srai	a5,a5,0x10
aaaad1e8:	00b70733          	add	a4,a4,a1
aaaad1ec:	fd0554e3          	bge	a0,a6,aaaad1b4 <calc_func+0x1c84>
aaaad1f0:	00468693          	addi	a3,a3,4
aaaad1f4:	00000813          	li	a6,0
aaaad1f8:	fd1696e3          	bne	a3,a7,aaaad1c4 <calc_func+0x1c94>
aaaad1fc:	407288b3          	sub	a7,t0,t2
aaaad200:	001e0713          	addi	a4,t3,1
aaaad204:	a7cf0ce3          	beq	t5,t3,aaaacc7c <calc_func+0x174c>
aaaad208:	00070e13          	mv	t3,a4
aaaad20c:	f9dff06f          	j	aaaad1a8 <calc_func+0x1c78>
aaaad210:	00000f13          	li	t5,0
aaaad214:	00000a93          	li	s5,0
aaaad218:	40560b33          	sub	s6,a2,t0
aaaad21c:	002f1693          	slli	a3,t5,0x2
aaaad220:	000b0793          	mv	a5,s6
aaaad224:	007686b3          	add	a3,a3,t2
aaaad228:	00079703          	lh	a4,0(a5)
aaaad22c:	00278793          	addi	a5,a5,2
aaaad230:	00468693          	addi	a3,a3,4
aaaad234:	02670733          	mul	a4,a4,t1
aaaad238:	fee6ae23          	sw	a4,-4(a3)
aaaad23c:	fec796e3          	bne	a5,a2,aaaad228 <calc_func+0x1cf8>
aaaad240:	00bf0f33          	add	t5,t5,a1
aaaad244:	410b0633          	sub	a2,s6,a6
aaaad248:	001a8793          	addi	a5,s5,1
aaaad24c:	09588c63          	beq	a7,s5,aaaad2e4 <calc_func+0x1db4>
aaaad250:	00078a93          	mv	s5,a5
aaaad254:	fc5ff06f          	j	aaaad218 <calc_func+0x1ce8>
aaaad258:	41d00833          	neg	a6,t4
aaaad25c:	002e9893          	slli	a7,t4,0x2
aaaad260:	00281b93          	slli	s7,a6,0x2
aaaad264:	00381c13          	slli	s8,a6,0x3
aaaad268:	011388b3          	add	a7,t2,a7
aaaad26c:	00000593          	li	a1,0
aaaad270:	00000813          	li	a6,0
aaaad274:	00000793          	li	a5,0
aaaad278:	00000b13          	li	s6,0
aaaad27c:	011b8ab3          	add	s5,s7,a7
aaaad280:	000a8693          	mv	a3,s5
aaaad284:	0140006f          	j	aaaad298 <calc_func+0x1d68>
aaaad288:	01071793          	slli	a5,a4,0x10
aaaad28c:	00468693          	addi	a3,a3,4
aaaad290:	4107d793          	srai	a5,a5,0x10
aaaad294:	02d88e63          	beq	a7,a3,aaaad2d0 <calc_func+0x1da0>
aaaad298:	00058613          	mv	a2,a1
aaaad29c:	01079713          	slli	a4,a5,0x10
aaaad2a0:	0006a583          	lw	a1,0(a3)
aaaad2a4:	01075713          	srli	a4,a4,0x10
aaaad2a8:	00a70793          	addi	a5,a4,10
aaaad2ac:	00b62633          	slt	a2,a2,a1
aaaad2b0:	01079793          	slli	a5,a5,0x10
aaaad2b4:	00b80833          	add	a6,a6,a1
aaaad2b8:	4107d793          	srai	a5,a5,0x10
aaaad2bc:	00c70733          	add	a4,a4,a2
aaaad2c0:	fd0554e3          	bge	a0,a6,aaaad288 <calc_func+0x1d58>
aaaad2c4:	00468693          	addi	a3,a3,4
aaaad2c8:	00000813          	li	a6,0
aaaad2cc:	fcd896e3          	bne	a7,a3,aaaad298 <calc_func+0x1d68>
aaaad2d0:	418a88b3          	sub	a7,s5,s8
aaaad2d4:	001b0713          	addi	a4,s6,1
aaaad2d8:	eb6f0863          	beq	t5,s6,aaaac988 <calc_func+0x1458>
aaaad2dc:	00070b13          	mv	s6,a4
aaaad2e0:	f9dff06f          	j	aaaad27c <calc_func+0x1d4c>
aaaad2e4:	40b005b3          	neg	a1,a1
aaaad2e8:	00359a93          	slli	s5,a1,0x3
aaaad2ec:	410382b3          	sub	t0,t2,a6
aaaad2f0:	00000613          	li	a2,0
aaaad2f4:	00000f13          	li	t5,0
aaaad2f8:	00000793          	li	a5,0
aaaad2fc:	00000b13          	li	s6,0
aaaad300:	01028bb3          	add	s7,t0,a6
aaaad304:	000b8693          	mv	a3,s7
aaaad308:	0140006f          	j	aaaad31c <calc_func+0x1dec>
aaaad30c:	01071793          	slli	a5,a4,0x10
aaaad310:	00468693          	addi	a3,a3,4
aaaad314:	4107d793          	srai	a5,a5,0x10
aaaad318:	02d28e63          	beq	t0,a3,aaaad354 <calc_func+0x1e24>
aaaad31c:	00060593          	mv	a1,a2
aaaad320:	01079713          	slli	a4,a5,0x10
aaaad324:	0006a603          	lw	a2,0(a3)
aaaad328:	01075713          	srli	a4,a4,0x10
aaaad32c:	00a70793          	addi	a5,a4,10
aaaad330:	00c5a5b3          	slt	a1,a1,a2
aaaad334:	01079793          	slli	a5,a5,0x10
aaaad338:	00cf0f33          	add	t5,t5,a2
aaaad33c:	4107d793          	srai	a5,a5,0x10
aaaad340:	00b70733          	add	a4,a4,a1
aaaad344:	fde554e3          	bge	a0,t5,aaaad30c <calc_func+0x1ddc>
aaaad348:	00468693          	addi	a3,a3,4
aaaad34c:	00000f13          	li	t5,0
aaaad350:	fcd296e3          	bne	t0,a3,aaaad31c <calc_func+0x1dec>
aaaad354:	415b82b3          	sub	t0,s7,s5
aaaad358:	001b0713          	addi	a4,s6,1
aaaad35c:	83688463          	beq	a7,s6,aaaac384 <calc_func+0xe54>
aaaad360:	00070b13          	mv	s6,a4
aaaad364:	f9dff06f          	j	aaaad300 <calc_func+0x1dd0>
aaaad368:	01aa8d33          	add	s10,s5,s10
aaaad36c:	00098813          	mv	a6,s3
aaaad370:	01aaf463          	bgeu	s5,s10,aaaad378 <calc_func+0x1e48>
aaaad374:	e10fe06f          	j	aaaab984 <calc_func+0x454>
aaaad378:	e90fe06f          	j	aaaaba08 <calc_func+0x4d8>
aaaad37c:	00000f13          	li	t5,0
aaaad380:	00000713          	li	a4,0
aaaad384:	b30ff06f          	j	aaaac6b4 <calc_func+0x1184>

aaaad388 <core_bench_list>:
aaaad388:	00451883          	lh	a7,4(a0)
aaaad38c:	fb010113          	addi	sp,sp,-80
aaaad390:	04812423          	sw	s0,72(sp)
aaaad394:	03412c23          	sw	s4,56(sp)
aaaad398:	03612823          	sw	s6,48(sp)
aaaad39c:	03812423          	sw	s8,40(sp)
aaaad3a0:	04112623          	sw	ra,76(sp)
aaaad3a4:	04912223          	sw	s1,68(sp)
aaaad3a8:	05212023          	sw	s2,64(sp)
aaaad3ac:	03312e23          	sw	s3,60(sp)
aaaad3b0:	03512a23          	sw	s5,52(sp)
aaaad3b4:	03712623          	sw	s7,44(sp)
aaaad3b8:	03912223          	sw	s9,36(sp)
aaaad3bc:	03a12023          	sw	s10,32(sp)
aaaad3c0:	01b12e23          	sw	s11,28(sp)
aaaad3c4:	02452403          	lw	s0,36(a0)
aaaad3c8:	00050a13          	mv	s4,a0
aaaad3cc:	00058b13          	mv	s6,a1
aaaad3d0:	00000c13          	li	s8,0
aaaad3d4:	21105ee3          	blez	a7,aaaaddf0 <core_bench_list+0xa68>
aaaad3d8:	fff00793          	li	a5,-1
aaaad3dc:	22f580e3          	beq	a1,a5,aaaaddfc <core_bench_list+0xa74>
aaaad3e0:	240404e3          	beqz	s0,aaaade28 <core_bench_list+0xaa0>
aaaad3e4:	00000593          	li	a1,0
aaaad3e8:	00000813          	li	a6,0
aaaad3ec:	00000513          	li	a0,0
aaaad3f0:	00000913          	li	s2,0
aaaad3f4:	00100d13          	li	s10,1
aaaad3f8:	00040793          	mv	a5,s0
aaaad3fc:	00c0006f          	j	aaaad408 <core_bench_list+0x80>
aaaad400:	0007a783          	lw	a5,0(a5)
aaaad404:	10078063          	beqz	a5,aaaad504 <core_bench_list+0x17c>
aaaad408:	0047a703          	lw	a4,4(a5)
aaaad40c:	00271603          	lh	a2,2(a4)
aaaad410:	ffa618e3          	bne	a2,s10,aaaad400 <core_bench_list+0x78>
aaaad414:	00000693          	li	a3,0
aaaad418:	0080006f          	j	aaaad420 <core_bench_list+0x98>
aaaad41c:	00070413          	mv	s0,a4
aaaad420:	00042703          	lw	a4,0(s0)
aaaad424:	00d42023          	sw	a3,0(s0)
aaaad428:	00040693          	mv	a3,s0
aaaad42c:	fe0718e3          	bnez	a4,aaaad41c <core_bench_list+0x94>
aaaad430:	0c078e63          	beqz	a5,aaaad50c <core_bench_list+0x184>
aaaad434:	0047a703          	lw	a4,4(a5)
aaaad438:	00071703          	lh	a4,0(a4)
aaaad43c:	00177693          	andi	a3,a4,1
aaaad440:	00068c63          	beqz	a3,aaaad458 <core_bench_list+0xd0>
aaaad444:	40975713          	srai	a4,a4,0x9
aaaad448:	00177713          	andi	a4,a4,1
aaaad44c:	00e90733          	add	a4,s2,a4
aaaad450:	01071913          	slli	s2,a4,0x10
aaaad454:	01095913          	srli	s2,s2,0x10
aaaad458:	0007a703          	lw	a4,0(a5)
aaaad45c:	00070c63          	beqz	a4,aaaad474 <core_bench_list+0xec>
aaaad460:	00072683          	lw	a3,0(a4)
aaaad464:	00d7a023          	sw	a3,0(a5)
aaaad468:	00042783          	lw	a5,0(s0)
aaaad46c:	00f72023          	sw	a5,0(a4)
aaaad470:	00e42023          	sw	a4,0(s0)
aaaad474:	00150513          	addi	a0,a0,1
aaaad478:	01051513          	slli	a0,a0,0x10
aaaad47c:	01055513          	srli	a0,a0,0x10
aaaad480:	00158793          	addi	a5,a1,1
aaaad484:	01079593          	slli	a1,a5,0x10
aaaad488:	4105d593          	srai	a1,a1,0x10
aaaad48c:	06064063          	bltz	a2,aaaad4ec <core_bench_list+0x164>
aaaad490:	00160613          	addi	a2,a2,1
aaaad494:	01061d13          	slli	s10,a2,0x10
aaaad498:	01079793          	slli	a5,a5,0x10
aaaad49c:	410d5d13          	srai	s10,s10,0x10
aaaad4a0:	0107d793          	srli	a5,a5,0x10
aaaad4a4:	08b88c63          	beq	a7,a1,aaaad53c <core_bench_list+0x1b4>
aaaad4a8:	0ff7fc13          	zext.b	s8,a5
aaaad4ac:	000c0693          	mv	a3,s8
aaaad4b0:	00040793          	mv	a5,s0
aaaad4b4:	ffff8637          	lui	a2,0xffff8
aaaad4b8:	f40d50e3          	bgez	s10,aaaad3f8 <core_bench_list+0x70>
aaaad4bc:	0047a703          	lw	a4,4(a5)
aaaad4c0:	00074c03          	lbu	s8,0(a4)
aaaad4c4:	f4dc08e3          	beq	s8,a3,aaaad414 <core_bench_list+0x8c>
aaaad4c8:	0007a783          	lw	a5,0(a5)
aaaad4cc:	00078c63          	beqz	a5,aaaad4e4 <core_bench_list+0x15c>
aaaad4d0:	0047a703          	lw	a4,4(a5)
aaaad4d4:	00074c03          	lbu	s8,0(a4)
aaaad4d8:	f2dc0ee3          	beq	s8,a3,aaaad414 <core_bench_list+0x8c>
aaaad4dc:	0007a783          	lw	a5,0(a5)
aaaad4e0:	fe0798e3          	bnez	a5,aaaad4d0 <core_bench_list+0x148>
aaaad4e4:	00068c13          	mv	s8,a3
aaaad4e8:	f2dff06f          	j	aaaad414 <core_bench_list+0x8c>
aaaad4ec:	01079793          	slli	a5,a5,0x10
aaaad4f0:	0107d793          	srli	a5,a5,0x10
aaaad4f4:	04b88263          	beq	a7,a1,aaaad538 <core_bench_list+0x1b0>
aaaad4f8:	0ff7f693          	zext.b	a3,a5
aaaad4fc:	00040793          	mv	a5,s0
aaaad500:	fd1ff06f          	j	aaaad4d0 <core_bench_list+0x148>
aaaad504:	000d0613          	mv	a2,s10
aaaad508:	f0dff06f          	j	aaaad414 <core_bench_list+0x8c>
aaaad50c:	00042783          	lw	a5,0(s0)
aaaad510:	00180813          	addi	a6,a6,1
aaaad514:	01081813          	slli	a6,a6,0x10
aaaad518:	0047a783          	lw	a5,4(a5)
aaaad51c:	01085813          	srli	a6,a6,0x10
aaaad520:	00178783          	lb	a5,1(a5)
aaaad524:	0017f793          	andi	a5,a5,1
aaaad528:	00f907b3          	add	a5,s2,a5
aaaad52c:	01079913          	slli	s2,a5,0x10
aaaad530:	01095913          	srli	s2,s2,0x10
aaaad534:	f4dff06f          	j	aaaad480 <core_bench_list+0xf8>
aaaad538:	00060d13          	mv	s10,a2
aaaad53c:	00251793          	slli	a5,a0,0x2
aaaad540:	410787b3          	sub	a5,a5,a6
aaaad544:	00f90933          	add	s2,s2,a5
aaaad548:	01091793          	slli	a5,s2,0x10
aaaad54c:	0107d793          	srli	a5,a5,0x10
aaaad550:	00f12623          	sw	a5,12(sp)
aaaad554:	00100793          	li	a5,1
aaaad558:	40fb0063          	beq	s6,a5,aaaad958 <core_bench_list+0x5d0>
aaaad55c:	00042783          	lw	a5,0(s0)
aaaad560:	00040693          	mv	a3,s0
aaaad564:	0007a803          	lw	a6,0(a5)
aaaad568:	0047aa83          	lw	s5,4(a5)
aaaad56c:	00482603          	lw	a2,4(a6)
aaaad570:	00082703          	lw	a4,0(a6)
aaaad574:	00c7a223          	sw	a2,4(a5)
aaaad578:	01582223          	sw	s5,4(a6)
aaaad57c:	00e7a023          	sw	a4,0(a5)
aaaad580:	00082023          	sw	zero,0(a6)
aaaad584:	480d4c63          	bltz	s10,aaaada1c <core_bench_list+0x694>
aaaad588:	0046a783          	lw	a5,4(a3)
aaaad58c:	00279783          	lh	a5,2(a5)
aaaad590:	01a78c63          	beq	a5,s10,aaaad5a8 <core_bench_list+0x220>
aaaad594:	0006a683          	lw	a3,0(a3)
aaaad598:	00068ae3          	beqz	a3,aaaaddac <core_bench_list+0xa24>
aaaad59c:	0046a783          	lw	a5,4(a3)
aaaad5a0:	00279783          	lh	a5,2(a5)
aaaad5a4:	ffa798e3          	bne	a5,s10,aaaad594 <core_bench_list+0x20c>
aaaad5a8:	00042503          	lw	a0,0(s0)
aaaad5ac:	00442703          	lw	a4,4(s0)
aaaad5b0:	ffffa7b7          	lui	a5,0xffffa
aaaad5b4:	00178793          	addi	a5,a5,1 # ffffa001 <_stack_top+0xfffa001>
aaaad5b8:	00071603          	lh	a2,0(a4)
aaaad5bc:	01061593          	slli	a1,a2,0x10
aaaad5c0:	0105d593          	srli	a1,a1,0x10
aaaad5c4:	0ff67613          	zext.b	a2,a2
aaaad5c8:	0085d293          	srli	t0,a1,0x8
aaaad5cc:	0095df93          	srli	t6,a1,0x9
aaaad5d0:	00a5df13          	srli	t5,a1,0xa
aaaad5d4:	00b5de93          	srli	t4,a1,0xb
aaaad5d8:	00c5de13          	srli	t3,a1,0xc
aaaad5dc:	00d5d313          	srli	t1,a1,0xd
aaaad5e0:	00e5d893          	srli	a7,a1,0xe
aaaad5e4:	00165c13          	srli	s8,a2,0x1
aaaad5e8:	00265b93          	srli	s7,a2,0x2
aaaad5ec:	00365b13          	srli	s6,a2,0x3
aaaad5f0:	00465a13          	srli	s4,a2,0x4
aaaad5f4:	00565993          	srli	s3,a2,0x5
aaaad5f8:	00665493          	srli	s1,a2,0x6
aaaad5fc:	00765393          	srli	t2,a2,0x7
aaaad600:	00f5d593          	srli	a1,a1,0xf
aaaad604:	00c12903          	lw	s2,12(sp)
aaaad608:	0006a683          	lw	a3,0(a3)
aaaad60c:	01264733          	xor	a4,a2,s2
aaaad610:	00177713          	andi	a4,a4,1
aaaad614:	40e00733          	neg	a4,a4
aaaad618:	00195913          	srli	s2,s2,0x1
aaaad61c:	00f77733          	and	a4,a4,a5
aaaad620:	01274733          	xor	a4,a4,s2
aaaad624:	01071713          	slli	a4,a4,0x10
aaaad628:	01075713          	srli	a4,a4,0x10
aaaad62c:	00ec4933          	xor	s2,s8,a4
aaaad630:	00197913          	andi	s2,s2,1
aaaad634:	41200933          	neg	s2,s2
aaaad638:	00175713          	srli	a4,a4,0x1
aaaad63c:	00f97933          	and	s2,s2,a5
aaaad640:	00e94933          	xor	s2,s2,a4
aaaad644:	01091913          	slli	s2,s2,0x10
aaaad648:	01095913          	srli	s2,s2,0x10
aaaad64c:	012bc733          	xor	a4,s7,s2
aaaad650:	00177713          	andi	a4,a4,1
aaaad654:	40e00733          	neg	a4,a4
aaaad658:	00195913          	srli	s2,s2,0x1
aaaad65c:	00f77733          	and	a4,a4,a5
aaaad660:	01274733          	xor	a4,a4,s2
aaaad664:	01071713          	slli	a4,a4,0x10
aaaad668:	01075713          	srli	a4,a4,0x10
aaaad66c:	00eb4933          	xor	s2,s6,a4
aaaad670:	00197913          	andi	s2,s2,1
aaaad674:	41200933          	neg	s2,s2
aaaad678:	00175713          	srli	a4,a4,0x1
aaaad67c:	00f97933          	and	s2,s2,a5
aaaad680:	00e94933          	xor	s2,s2,a4
aaaad684:	01091913          	slli	s2,s2,0x10
aaaad688:	01095913          	srli	s2,s2,0x10
aaaad68c:	012a4733          	xor	a4,s4,s2
aaaad690:	00177713          	andi	a4,a4,1
aaaad694:	40e00733          	neg	a4,a4
aaaad698:	00195913          	srli	s2,s2,0x1
aaaad69c:	00f77733          	and	a4,a4,a5
aaaad6a0:	01274733          	xor	a4,a4,s2
aaaad6a4:	01071713          	slli	a4,a4,0x10
aaaad6a8:	01075713          	srli	a4,a4,0x10
aaaad6ac:	00e9c933          	xor	s2,s3,a4
aaaad6b0:	00197913          	andi	s2,s2,1
aaaad6b4:	41200933          	neg	s2,s2
aaaad6b8:	00175713          	srli	a4,a4,0x1
aaaad6bc:	00f97933          	and	s2,s2,a5
aaaad6c0:	00e94933          	xor	s2,s2,a4
aaaad6c4:	01091913          	slli	s2,s2,0x10
aaaad6c8:	01095913          	srli	s2,s2,0x10
aaaad6cc:	0124c733          	xor	a4,s1,s2
aaaad6d0:	00177713          	andi	a4,a4,1
aaaad6d4:	40e00733          	neg	a4,a4
aaaad6d8:	00195913          	srli	s2,s2,0x1
aaaad6dc:	00f77733          	and	a4,a4,a5
aaaad6e0:	01274733          	xor	a4,a4,s2
aaaad6e4:	01071713          	slli	a4,a4,0x10
aaaad6e8:	01075713          	srli	a4,a4,0x10
aaaad6ec:	00e3c933          	xor	s2,t2,a4
aaaad6f0:	00197913          	andi	s2,s2,1
aaaad6f4:	41200933          	neg	s2,s2
aaaad6f8:	00175713          	srli	a4,a4,0x1
aaaad6fc:	00f97933          	and	s2,s2,a5
aaaad700:	00e94933          	xor	s2,s2,a4
aaaad704:	01091913          	slli	s2,s2,0x10
aaaad708:	01095913          	srli	s2,s2,0x10
aaaad70c:	0122c733          	xor	a4,t0,s2
aaaad710:	00177713          	andi	a4,a4,1
aaaad714:	40e00733          	neg	a4,a4
aaaad718:	00195913          	srli	s2,s2,0x1
aaaad71c:	00f77733          	and	a4,a4,a5
aaaad720:	01274733          	xor	a4,a4,s2
aaaad724:	01071713          	slli	a4,a4,0x10
aaaad728:	01075713          	srli	a4,a4,0x10
aaaad72c:	00efc933          	xor	s2,t6,a4
aaaad730:	00197913          	andi	s2,s2,1
aaaad734:	41200933          	neg	s2,s2
aaaad738:	00175713          	srli	a4,a4,0x1
aaaad73c:	00f97933          	and	s2,s2,a5
aaaad740:	00e94933          	xor	s2,s2,a4
aaaad744:	01091913          	slli	s2,s2,0x10
aaaad748:	01095913          	srli	s2,s2,0x10
aaaad74c:	012f4733          	xor	a4,t5,s2
aaaad750:	00177713          	andi	a4,a4,1
aaaad754:	40e00733          	neg	a4,a4
aaaad758:	00195913          	srli	s2,s2,0x1
aaaad75c:	00f77733          	and	a4,a4,a5
aaaad760:	01274733          	xor	a4,a4,s2
aaaad764:	01071713          	slli	a4,a4,0x10
aaaad768:	01075713          	srli	a4,a4,0x10
aaaad76c:	00eec933          	xor	s2,t4,a4
aaaad770:	00197913          	andi	s2,s2,1
aaaad774:	41200933          	neg	s2,s2
aaaad778:	00175713          	srli	a4,a4,0x1
aaaad77c:	00f97933          	and	s2,s2,a5
aaaad780:	00e94933          	xor	s2,s2,a4
aaaad784:	01091913          	slli	s2,s2,0x10
aaaad788:	01095913          	srli	s2,s2,0x10
aaaad78c:	012e4733          	xor	a4,t3,s2
aaaad790:	00177713          	andi	a4,a4,1
aaaad794:	40e00733          	neg	a4,a4
aaaad798:	00195913          	srli	s2,s2,0x1
aaaad79c:	00f77733          	and	a4,a4,a5
aaaad7a0:	01274733          	xor	a4,a4,s2
aaaad7a4:	01071713          	slli	a4,a4,0x10
aaaad7a8:	01075713          	srli	a4,a4,0x10
aaaad7ac:	00e34933          	xor	s2,t1,a4
aaaad7b0:	00197913          	andi	s2,s2,1
aaaad7b4:	41200933          	neg	s2,s2
aaaad7b8:	00175713          	srli	a4,a4,0x1
aaaad7bc:	00f97933          	and	s2,s2,a5
aaaad7c0:	00e94933          	xor	s2,s2,a4
aaaad7c4:	01091913          	slli	s2,s2,0x10
aaaad7c8:	01095913          	srli	s2,s2,0x10
aaaad7cc:	0128c733          	xor	a4,a7,s2
aaaad7d0:	00177713          	andi	a4,a4,1
aaaad7d4:	40e00733          	neg	a4,a4
aaaad7d8:	00195913          	srli	s2,s2,0x1
aaaad7dc:	00f77733          	and	a4,a4,a5
aaaad7e0:	01274733          	xor	a4,a4,s2
aaaad7e4:	01071713          	slli	a4,a4,0x10
aaaad7e8:	01075713          	srli	a4,a4,0x10
aaaad7ec:	00e5c933          	xor	s2,a1,a4
aaaad7f0:	00197913          	andi	s2,s2,1
aaaad7f4:	41200933          	neg	s2,s2
aaaad7f8:	00175713          	srli	a4,a4,0x1
aaaad7fc:	00f97933          	and	s2,s2,a5
aaaad800:	00e94933          	xor	s2,s2,a4
aaaad804:	01091713          	slli	a4,s2,0x10
aaaad808:	01075713          	srli	a4,a4,0x10
aaaad80c:	00e12623          	sw	a4,12(sp)
aaaad810:	de069ae3          	bnez	a3,aaaad604 <core_bench_list+0x27c>
aaaad814:	00452703          	lw	a4,4(a0)
aaaad818:	00052783          	lw	a5,0(a0)
aaaad81c:	00100e93          	li	t4,1
aaaad820:	00e82223          	sw	a4,4(a6)
aaaad824:	01552223          	sw	s5,4(a0)
aaaad828:	00f82023          	sw	a5,0(a6)
aaaad82c:	01052023          	sw	a6,0(a0)
aaaad830:	000e8293          	mv	t0,t4
aaaad834:	22040863          	beqz	s0,aaaada64 <core_bench_list+0x6dc>
aaaad838:	00000f13          	li	t5,0
aaaad83c:	00000693          	li	a3,0
aaaad840:	00000f93          	li	t6,0
aaaad844:	001f8f93          	addi	t6,t6,1
aaaad848:	00040613          	mv	a2,s0
aaaad84c:	00000793          	li	a5,0
aaaad850:	01d7d863          	bge	a5,t4,aaaad860 <core_bench_list+0x4d8>
aaaad854:	00062603          	lw	a2,0(a2) # ffff8000 <_stack_top+0xfff8000>
aaaad858:	00178793          	addi	a5,a5,1
aaaad85c:	fe061ae3          	bnez	a2,aaaad850 <core_bench_list+0x4c8>
aaaad860:	00068713          	mv	a4,a3
aaaad864:	000e8593          	mv	a1,t4
aaaad868:	00040693          	mv	a3,s0
aaaad86c:	00060413          	mv	s0,a2
aaaad870:	02f05463          	blez	a5,aaaad898 <core_bench_list+0x510>
aaaad874:	1e058c63          	beqz	a1,aaaada6c <core_bench_list+0x6e4>
aaaad878:	02041663          	bnez	s0,aaaad8a4 <core_bench_list+0x51c>
aaaad87c:	00068613          	mv	a2,a3
aaaad880:	fff78793          	addi	a5,a5,-1
aaaad884:	0006a683          	lw	a3,0(a3)
aaaad888:	06070c63          	beqz	a4,aaaad900 <core_bench_list+0x578>
aaaad88c:	00c72023          	sw	a2,0(a4)
aaaad890:	00060713          	mv	a4,a2
aaaad894:	fef040e3          	bgtz	a5,aaaad874 <core_bench_list+0x4ec>
aaaad898:	50b05463          	blez	a1,aaaadda0 <core_bench_list+0xa18>
aaaad89c:	20040463          	beqz	s0,aaaadaa4 <core_bench_list+0x71c>
aaaad8a0:	22078663          	beqz	a5,aaaadacc <core_bench_list+0x744>
aaaad8a4:	0046a803          	lw	a6,4(a3)
aaaad8a8:	00442503          	lw	a0,4(s0)
aaaad8ac:	00081603          	lh	a2,0(a6)
aaaad8b0:	00251303          	lh	t1,2(a0)
aaaad8b4:	00281e03          	lh	t3,2(a6)
aaaad8b8:	01061893          	slli	a7,a2,0x10
aaaad8bc:	0108d893          	srli	a7,a7,0x10
aaaad8c0:	f0067613          	andi	a2,a2,-256
aaaad8c4:	0088d893          	srli	a7,a7,0x8
aaaad8c8:	01166633          	or	a2,a2,a7
aaaad8cc:	00c81023          	sh	a2,0(a6)
aaaad8d0:	00051603          	lh	a2,0(a0)
aaaad8d4:	01061813          	slli	a6,a2,0x10
aaaad8d8:	01085813          	srli	a6,a6,0x10
aaaad8dc:	f0067613          	andi	a2,a2,-256
aaaad8e0:	00885813          	srli	a6,a6,0x8
aaaad8e4:	01066633          	or	a2,a2,a6
aaaad8e8:	00c51023          	sh	a2,0(a0)
aaaad8ec:	f9c358e3          	bge	t1,t3,aaaad87c <core_bench_list+0x4f4>
aaaad8f0:	00040613          	mv	a2,s0
aaaad8f4:	fff58593          	addi	a1,a1,-1
aaaad8f8:	00042403          	lw	s0,0(s0)
aaaad8fc:	f80718e3          	bnez	a4,aaaad88c <core_bench_list+0x504>
aaaad900:	00060f13          	mv	t5,a2
aaaad904:	00060713          	mv	a4,a2
aaaad908:	f8dff06f          	j	aaaad894 <core_bench_list+0x50c>
aaaad90c:	000da703          	lw	a4,0(s11)
aaaad910:	fff48493          	addi	s1,s1,-1
aaaad914:	02098063          	beqz	s3,aaaad934 <core_bench_list+0x5ac>
aaaad918:	01b9a023          	sw	s11,0(s3)
aaaad91c:	02048063          	beqz	s1,aaaad93c <core_bench_list+0x5b4>
aaaad920:	000d8993          	mv	s3,s11
aaaad924:	00070d93          	mv	s11,a4
aaaad928:	000da703          	lw	a4,0(s11)
aaaad92c:	fff48493          	addi	s1,s1,-1
aaaad930:	fe0994e3          	bnez	s3,aaaad918 <core_bench_list+0x590>
aaaad934:	000d8b93          	mv	s7,s11
aaaad938:	fe0494e3          	bnez	s1,aaaad920 <core_bench_list+0x598>
aaaad93c:	02041663          	bnez	s0,aaaad968 <core_bench_list+0x5e0>
aaaad940:	000d8993          	mv	s3,s11
aaaad944:	0009a023          	sw	zero,0(s3)
aaaad948:	00100793          	li	a5,1
aaaad94c:	48fc8e63          	beq	s9,a5,aaaadde8 <core_bench_list+0xa60>
aaaad950:	001b1b13          	slli	s6,s6,0x1
aaaad954:	000b8413          	mv	s0,s7
aaaad958:	10040663          	beqz	s0,aaaada64 <core_bench_list+0x6dc>
aaaad95c:	00000b93          	li	s7,0
aaaad960:	00000d93          	li	s11,0
aaaad964:	00000c93          	li	s9,0
aaaad968:	001c8c93          	addi	s9,s9,1
aaaad96c:	00040693          	mv	a3,s0
aaaad970:	00000493          	li	s1,0
aaaad974:	0164d863          	bge	s1,s6,aaaad984 <core_bench_list+0x5fc>
aaaad978:	0006a683          	lw	a3,0(a3)
aaaad97c:	00148493          	addi	s1,s1,1
aaaad980:	fe069ae3          	bnez	a3,aaaad974 <core_bench_list+0x5ec>
aaaad984:	000d8993          	mv	s3,s11
aaaad988:	000b0913          	mv	s2,s6
aaaad98c:	00040d93          	mv	s11,s0
aaaad990:	00068413          	mv	s0,a3
aaaad994:	02905463          	blez	s1,aaaad9bc <core_bench_list+0x634>
aaaad998:	f6090ae3          	beqz	s2,aaaad90c <core_bench_list+0x584>
aaaad99c:	02041663          	bnez	s0,aaaad9c8 <core_bench_list+0x640>
aaaad9a0:	000d8693          	mv	a3,s11
aaaad9a4:	fff48493          	addi	s1,s1,-1
aaaad9a8:	000dad83          	lw	s11,0(s11)
aaaad9ac:	04098e63          	beqz	s3,aaaada08 <core_bench_list+0x680>
aaaad9b0:	00d9a023          	sw	a3,0(s3)
aaaad9b4:	00068993          	mv	s3,a3
aaaad9b8:	fe9040e3          	bgtz	s1,aaaad998 <core_bench_list+0x610>
aaaad9bc:	43205063          	blez	s2,aaaadddc <core_bench_list+0xa54>
aaaad9c0:	f80402e3          	beqz	s0,aaaad944 <core_bench_list+0x5bc>
aaaad9c4:	06048e63          	beqz	s1,aaaada40 <core_bench_list+0x6b8>
aaaad9c8:	004da503          	lw	a0,4(s11)
aaaad9cc:	00442a83          	lw	s5,4(s0)
aaaad9d0:	000a0593          	mv	a1,s4
aaaad9d4:	ffffe097          	auipc	ra,0xffffe
aaaad9d8:	b5c080e7          	jalr	-1188(ra) # aaaab530 <calc_func>
aaaad9dc:	00050693          	mv	a3,a0
aaaad9e0:	000a0593          	mv	a1,s4
aaaad9e4:	000a8513          	mv	a0,s5
aaaad9e8:	00068a93          	mv	s5,a3
aaaad9ec:	ffffe097          	auipc	ra,0xffffe
aaaad9f0:	b44080e7          	jalr	-1212(ra) # aaaab530 <calc_func>
aaaad9f4:	fb5556e3          	bge	a0,s5,aaaad9a0 <core_bench_list+0x618>
aaaad9f8:	00040693          	mv	a3,s0
aaaad9fc:	fff90913          	addi	s2,s2,-1
aaaada00:	00042403          	lw	s0,0(s0)
aaaada04:	fa0996e3          	bnez	s3,aaaad9b0 <core_bench_list+0x628>
aaaada08:	00068b93          	mv	s7,a3
aaaada0c:	00068993          	mv	s3,a3
aaaada10:	fa9ff06f          	j	aaaad9b8 <core_bench_list+0x630>
aaaada14:	0006a683          	lw	a3,0(a3)
aaaada18:	38068a63          	beqz	a3,aaaaddac <core_bench_list+0xa24>
aaaada1c:	0046a783          	lw	a5,4(a3)
aaaada20:	0007c783          	lbu	a5,0(a5)
aaaada24:	fefc18e3          	bne	s8,a5,aaaada14 <core_bench_list+0x68c>
aaaada28:	b81ff06f          	j	aaaad5a8 <core_bench_list+0x220>
aaaada2c:	00040b93          	mv	s7,s0
aaaada30:	02090263          	beqz	s2,aaaada54 <core_bench_list+0x6cc>
aaaada34:	00040993          	mv	s3,s0
aaaada38:	f00686e3          	beqz	a3,aaaad944 <core_bench_list+0x5bc>
aaaada3c:	00068413          	mv	s0,a3
aaaada40:	00042683          	lw	a3,0(s0)
aaaada44:	fff90913          	addi	s2,s2,-1
aaaada48:	fe0982e3          	beqz	s3,aaaada2c <core_bench_list+0x6a4>
aaaada4c:	0089a023          	sw	s0,0(s3)
aaaada50:	fe0912e3          	bnez	s2,aaaada34 <core_bench_list+0x6ac>
aaaada54:	00040d93          	mv	s11,s0
aaaada58:	00068413          	mv	s0,a3
aaaada5c:	f00416e3          	bnez	s0,aaaad968 <core_bench_list+0x5e0>
aaaada60:	ee1ff06f          	j	aaaad940 <core_bench_list+0x5b8>
aaaada64:	00002023          	sw	zero,0(zero) # 0 <_start-0xaaaaa000>
aaaada68:	00100073          	ebreak
aaaada6c:	0006a603          	lw	a2,0(a3)
aaaada70:	fff78793          	addi	a5,a5,-1
aaaada74:	02070063          	beqz	a4,aaaada94 <core_bench_list+0x70c>
aaaada78:	00d72023          	sw	a3,0(a4)
aaaada7c:	02078063          	beqz	a5,aaaada9c <core_bench_list+0x714>
aaaada80:	00068713          	mv	a4,a3
aaaada84:	00060693          	mv	a3,a2
aaaada88:	0006a603          	lw	a2,0(a3)
aaaada8c:	fff78793          	addi	a5,a5,-1
aaaada90:	fe0714e3          	bnez	a4,aaaada78 <core_bench_list+0x6f0>
aaaada94:	00068f13          	mv	t5,a3
aaaada98:	fe0794e3          	bnez	a5,aaaada80 <core_bench_list+0x6f8>
aaaada9c:	da0414e3          	bnez	s0,aaaad844 <core_bench_list+0x4bc>
aaaadaa0:	00068713          	mv	a4,a3
aaaadaa4:	00072023          	sw	zero,0(a4)
aaaadaa8:	045f8463          	beq	t6,t0,aaaadaf0 <core_bench_list+0x768>
aaaadaac:	001e9e93          	slli	t4,t4,0x1
aaaadab0:	000f0413          	mv	s0,t5
aaaadab4:	d81ff06f          	j	aaaad834 <core_bench_list+0x4ac>
aaaadab8:	00040f13          	mv	t5,s0
aaaadabc:	02058263          	beqz	a1,aaaadae0 <core_bench_list+0x758>
aaaadac0:	00040713          	mv	a4,s0
aaaadac4:	fe0780e3          	beqz	a5,aaaadaa4 <core_bench_list+0x71c>
aaaadac8:	00078413          	mv	s0,a5
aaaadacc:	00042783          	lw	a5,0(s0)
aaaadad0:	fff58593          	addi	a1,a1,-1
aaaadad4:	fe0702e3          	beqz	a4,aaaadab8 <core_bench_list+0x730>
aaaadad8:	00872023          	sw	s0,0(a4)
aaaadadc:	fe0592e3          	bnez	a1,aaaadac0 <core_bench_list+0x738>
aaaadae0:	00040693          	mv	a3,s0
aaaadae4:	00078413          	mv	s0,a5
aaaadae8:	d4041ee3          	bnez	s0,aaaad844 <core_bench_list+0x4bc>
aaaadaec:	fb5ff06f          	j	aaaadaa0 <core_bench_list+0x718>
aaaadaf0:	000f2503          	lw	a0,0(t5)
aaaadaf4:	32050663          	beqz	a0,aaaade20 <core_bench_list+0xa98>
aaaadaf8:	004f2703          	lw	a4,4(t5)
aaaadafc:	ffffa7b7          	lui	a5,0xffffa
aaaadb00:	00178793          	addi	a5,a5,1 # ffffa001 <_stack_top+0xfffa001>
aaaadb04:	00071603          	lh	a2,0(a4)
aaaadb08:	01061593          	slli	a1,a2,0x10
aaaadb0c:	0105d593          	srli	a1,a1,0x10
aaaadb10:	0ff67613          	zext.b	a2,a2
aaaadb14:	0085df93          	srli	t6,a1,0x8
aaaadb18:	0095df13          	srli	t5,a1,0x9
aaaadb1c:	00a5de93          	srli	t4,a1,0xa
aaaadb20:	00b5de13          	srli	t3,a1,0xb
aaaadb24:	00c5d313          	srli	t1,a1,0xc
aaaadb28:	00d5d893          	srli	a7,a1,0xd
aaaadb2c:	00e5d813          	srli	a6,a1,0xe
aaaadb30:	00165a93          	srli	s5,a2,0x1
aaaadb34:	00265a13          	srli	s4,a2,0x2
aaaadb38:	00365993          	srli	s3,a2,0x3
aaaadb3c:	00465493          	srli	s1,a2,0x4
aaaadb40:	00565413          	srli	s0,a2,0x5
aaaadb44:	00665393          	srli	t2,a2,0x6
aaaadb48:	00765293          	srli	t0,a2,0x7
aaaadb4c:	00f5d593          	srli	a1,a1,0xf
aaaadb50:	00c12683          	lw	a3,12(sp)
aaaadb54:	00052503          	lw	a0,0(a0)
aaaadb58:	00d64733          	xor	a4,a2,a3
aaaadb5c:	00177713          	andi	a4,a4,1
aaaadb60:	40e00733          	neg	a4,a4
aaaadb64:	0016d913          	srli	s2,a3,0x1
aaaadb68:	00f77733          	and	a4,a4,a5
aaaadb6c:	01274733          	xor	a4,a4,s2
aaaadb70:	01071713          	slli	a4,a4,0x10
aaaadb74:	01075713          	srli	a4,a4,0x10
aaaadb78:	00eac6b3          	xor	a3,s5,a4
aaaadb7c:	0016f693          	andi	a3,a3,1
aaaadb80:	40d006b3          	neg	a3,a3
aaaadb84:	00175713          	srli	a4,a4,0x1
aaaadb88:	00f6f6b3          	and	a3,a3,a5
aaaadb8c:	00e6c6b3          	xor	a3,a3,a4
aaaadb90:	01069693          	slli	a3,a3,0x10
aaaadb94:	0106d693          	srli	a3,a3,0x10
aaaadb98:	00da4733          	xor	a4,s4,a3
aaaadb9c:	00177713          	andi	a4,a4,1
aaaadba0:	40e00733          	neg	a4,a4
aaaadba4:	0016d693          	srli	a3,a3,0x1
aaaadba8:	00f77733          	and	a4,a4,a5
aaaadbac:	00d74733          	xor	a4,a4,a3
aaaadbb0:	01071713          	slli	a4,a4,0x10
aaaadbb4:	01075713          	srli	a4,a4,0x10
aaaadbb8:	00e9c6b3          	xor	a3,s3,a4
aaaadbbc:	0016f693          	andi	a3,a3,1
aaaadbc0:	40d006b3          	neg	a3,a3
aaaadbc4:	00175713          	srli	a4,a4,0x1
aaaadbc8:	00f6f6b3          	and	a3,a3,a5
aaaadbcc:	00e6c6b3          	xor	a3,a3,a4
aaaadbd0:	01069693          	slli	a3,a3,0x10
aaaadbd4:	0106d693          	srli	a3,a3,0x10
aaaadbd8:	00d4c733          	xor	a4,s1,a3
aaaadbdc:	00177713          	andi	a4,a4,1
aaaadbe0:	40e00733          	neg	a4,a4
aaaadbe4:	0016d693          	srli	a3,a3,0x1
aaaadbe8:	00f77733          	and	a4,a4,a5
aaaadbec:	00d74733          	xor	a4,a4,a3
aaaadbf0:	01071713          	slli	a4,a4,0x10
aaaadbf4:	01075713          	srli	a4,a4,0x10
aaaadbf8:	00e446b3          	xor	a3,s0,a4
aaaadbfc:	0016f693          	andi	a3,a3,1
aaaadc00:	40d006b3          	neg	a3,a3
aaaadc04:	00175713          	srli	a4,a4,0x1
aaaadc08:	00f6f6b3          	and	a3,a3,a5
aaaadc0c:	00e6c6b3          	xor	a3,a3,a4
aaaadc10:	01069693          	slli	a3,a3,0x10
aaaadc14:	0106d693          	srli	a3,a3,0x10
aaaadc18:	00d3c733          	xor	a4,t2,a3
aaaadc1c:	00177713          	andi	a4,a4,1
aaaadc20:	40e00733          	neg	a4,a4
aaaadc24:	0016d693          	srli	a3,a3,0x1
aaaadc28:	00f77733          	and	a4,a4,a5
aaaadc2c:	00d74733          	xor	a4,a4,a3
aaaadc30:	01071713          	slli	a4,a4,0x10
aaaadc34:	01075713          	srli	a4,a4,0x10
aaaadc38:	00e2c6b3          	xor	a3,t0,a4
aaaadc3c:	0016f693          	andi	a3,a3,1
aaaadc40:	40d006b3          	neg	a3,a3
aaaadc44:	00175713          	srli	a4,a4,0x1
aaaadc48:	00f6f6b3          	and	a3,a3,a5
aaaadc4c:	00e6c6b3          	xor	a3,a3,a4
aaaadc50:	01069693          	slli	a3,a3,0x10
aaaadc54:	0106d693          	srli	a3,a3,0x10
aaaadc58:	00dfc733          	xor	a4,t6,a3
aaaadc5c:	00177713          	andi	a4,a4,1
aaaadc60:	40e00733          	neg	a4,a4
aaaadc64:	0016d693          	srli	a3,a3,0x1
aaaadc68:	00f77733          	and	a4,a4,a5
aaaadc6c:	00d74733          	xor	a4,a4,a3
aaaadc70:	01071713          	slli	a4,a4,0x10
aaaadc74:	01075713          	srli	a4,a4,0x10
aaaadc78:	00ef46b3          	xor	a3,t5,a4
aaaadc7c:	0016f693          	andi	a3,a3,1
aaaadc80:	40d006b3          	neg	a3,a3
aaaadc84:	00175713          	srli	a4,a4,0x1
aaaadc88:	00f6f6b3          	and	a3,a3,a5
aaaadc8c:	00e6c6b3          	xor	a3,a3,a4
aaaadc90:	01069693          	slli	a3,a3,0x10
aaaadc94:	0106d693          	srli	a3,a3,0x10
aaaadc98:	00dec733          	xor	a4,t4,a3
aaaadc9c:	00177713          	andi	a4,a4,1
aaaadca0:	40e00733          	neg	a4,a4
aaaadca4:	0016d693          	srli	a3,a3,0x1
aaaadca8:	00f77733          	and	a4,a4,a5
aaaadcac:	00d74733          	xor	a4,a4,a3
aaaadcb0:	01071713          	slli	a4,a4,0x10
aaaadcb4:	01075713          	srli	a4,a4,0x10
aaaadcb8:	00ee46b3          	xor	a3,t3,a4
aaaadcbc:	0016f693          	andi	a3,a3,1
aaaadcc0:	40d006b3          	neg	a3,a3
aaaadcc4:	00175713          	srli	a4,a4,0x1
aaaadcc8:	00f6f6b3          	and	a3,a3,a5
aaaadccc:	00e6c6b3          	xor	a3,a3,a4
aaaadcd0:	01069693          	slli	a3,a3,0x10
aaaadcd4:	0106d693          	srli	a3,a3,0x10
aaaadcd8:	00d34733          	xor	a4,t1,a3
aaaadcdc:	00177713          	andi	a4,a4,1
aaaadce0:	40e00733          	neg	a4,a4
aaaadce4:	0016d693          	srli	a3,a3,0x1
aaaadce8:	00f77733          	and	a4,a4,a5
aaaadcec:	00d74733          	xor	a4,a4,a3
aaaadcf0:	01071713          	slli	a4,a4,0x10
aaaadcf4:	01075713          	srli	a4,a4,0x10
aaaadcf8:	00e8c6b3          	xor	a3,a7,a4
aaaadcfc:	0016f693          	andi	a3,a3,1
aaaadd00:	40d006b3          	neg	a3,a3
aaaadd04:	00175713          	srli	a4,a4,0x1
aaaadd08:	00f6f6b3          	and	a3,a3,a5
aaaadd0c:	00e6c6b3          	xor	a3,a3,a4
aaaadd10:	01069693          	slli	a3,a3,0x10
aaaadd14:	0106d693          	srli	a3,a3,0x10
aaaadd18:	00d84733          	xor	a4,a6,a3
aaaadd1c:	00177713          	andi	a4,a4,1
aaaadd20:	40e00733          	neg	a4,a4
aaaadd24:	00f77733          	and	a4,a4,a5
aaaadd28:	0016d693          	srli	a3,a3,0x1
aaaadd2c:	00d74733          	xor	a4,a4,a3
aaaadd30:	01071713          	slli	a4,a4,0x10
aaaadd34:	01075713          	srli	a4,a4,0x10
aaaadd38:	00e5c933          	xor	s2,a1,a4
aaaadd3c:	00197913          	andi	s2,s2,1
aaaadd40:	41200933          	neg	s2,s2
aaaadd44:	00175713          	srli	a4,a4,0x1
aaaadd48:	00f97933          	and	s2,s2,a5
aaaadd4c:	00e94933          	xor	s2,s2,a4
aaaadd50:	01091713          	slli	a4,s2,0x10
aaaadd54:	01075713          	srli	a4,a4,0x10
aaaadd58:	00e12623          	sw	a4,12(sp)
aaaadd5c:	de051ae3          	bnez	a0,aaaadb50 <core_bench_list+0x7c8>
aaaadd60:	00070513          	mv	a0,a4
aaaadd64:	04c12083          	lw	ra,76(sp)
aaaadd68:	04812403          	lw	s0,72(sp)
aaaadd6c:	04412483          	lw	s1,68(sp)
aaaadd70:	04012903          	lw	s2,64(sp)
aaaadd74:	03c12983          	lw	s3,60(sp)
aaaadd78:	03812a03          	lw	s4,56(sp)
aaaadd7c:	03412a83          	lw	s5,52(sp)
aaaadd80:	03012b03          	lw	s6,48(sp)
aaaadd84:	02c12b83          	lw	s7,44(sp)
aaaadd88:	02812c03          	lw	s8,40(sp)
aaaadd8c:	02412c83          	lw	s9,36(sp)
aaaadd90:	02012d03          	lw	s10,32(sp)
aaaadd94:	01c12d83          	lw	s11,28(sp)
aaaadd98:	05010113          	addi	sp,sp,80
aaaadd9c:	00008067          	ret
aaaadda0:	00070693          	mv	a3,a4
aaaadda4:	aa0410e3          	bnez	s0,aaaad844 <core_bench_list+0x4bc>
aaaadda8:	cf9ff06f          	j	aaaadaa0 <core_bench_list+0x718>
aaaaddac:	00042503          	lw	a0,0(s0)
aaaaddb0:	00050693          	mv	a3,a0
aaaaddb4:	fe051c63          	bnez	a0,aaaad5ac <core_bench_list+0x224>
aaaaddb8:	00452703          	lw	a4,4(a0)
aaaaddbc:	00052783          	lw	a5,0(a0)
aaaaddc0:	00100e93          	li	t4,1
aaaaddc4:	00e82223          	sw	a4,4(a6)
aaaaddc8:	01552223          	sw	s5,4(a0)
aaaaddcc:	00f82023          	sw	a5,0(a6)
aaaaddd0:	01052023          	sw	a6,0(a0)
aaaaddd4:	000e8293          	mv	t0,t4
aaaaddd8:	a5dff06f          	j	aaaad834 <core_bench_list+0x4ac>
aaaadddc:	00098d93          	mv	s11,s3
aaaadde0:	b80414e3          	bnez	s0,aaaad968 <core_bench_list+0x5e0>
aaaadde4:	b5dff06f          	j	aaaad940 <core_bench_list+0x5b8>
aaaadde8:	000b8413          	mv	s0,s7
aaaaddec:	f70ff06f          	j	aaaad55c <core_bench_list+0x1d4>
aaaaddf0:	00058d13          	mv	s10,a1
aaaaddf4:	00012623          	sw	zero,12(sp)
aaaaddf8:	f5cff06f          	j	aaaad554 <core_bench_list+0x1cc>
aaaaddfc:	02040663          	beqz	s0,aaaade28 <core_bench_list+0xaa0>
aaaade00:	00058613          	mv	a2,a1
aaaade04:	00040793          	mv	a5,s0
aaaade08:	00000593          	li	a1,0
aaaade0c:	00000693          	li	a3,0
aaaade10:	00000813          	li	a6,0
aaaade14:	00000913          	li	s2,0
aaaade18:	00000513          	li	a0,0
aaaade1c:	eb4ff06f          	j	aaaad4d0 <core_bench_list+0x148>
aaaade20:	00c12503          	lw	a0,12(sp)
aaaade24:	f41ff06f          	j	aaaadd64 <core_bench_list+0x9dc>
aaaade28:	00002783          	lw	a5,0(zero) # 0 <_start-0xaaaaa000>
aaaade2c:	00100073          	ebreak

aaaade30 <main>:
aaaade30:	f8010113          	addi	sp,sp,-128
aaaade34:	00004697          	auipc	a3,0x4
aaaade38:	9a46a683          	lw	a3,-1628(a3) # aaab17d8 <seed1_volatile>
aaaade3c:	00004717          	auipc	a4,0x4
aaaade40:	99872703          	lw	a4,-1640(a4) # aaab17d4 <seed2_volatile>
aaaade44:	00002817          	auipc	a6,0x2
aaaade48:	2b082803          	lw	a6,688(a6) # aaab00f4 <seed3_volatile>
aaaade4c:	06812c23          	sw	s0,120(sp)
aaaade50:	00002417          	auipc	s0,0x2
aaaade54:	2a042403          	lw	s0,672(s0) # aaab00f0 <seed4_volatile>
aaaade58:	00004317          	auipc	t1,0x4
aaaade5c:	97832303          	lw	t1,-1672(t1) # aaab17d0 <seed5_volatile>
aaaade60:	00100793          	li	a5,1
aaaade64:	00d11623          	sh	a3,12(sp)
aaaade68:	00e11723          	sh	a4,14(sp)
aaaade6c:	01081813          	slli	a6,a6,0x10
aaaade70:	06112e23          	sw	ra,124(sp)
aaaade74:	06912a23          	sw	s1,116(sp)
aaaade78:	07212823          	sw	s2,112(sp)
aaaade7c:	07312623          	sw	s3,108(sp)
aaaade80:	07412423          	sw	s4,104(sp)
aaaade84:	07512223          	sw	s5,100(sp)
aaaade88:	07612023          	sw	s6,96(sp)
aaaade8c:	05712e23          	sw	s7,92(sp)
aaaade90:	05812c23          	sw	s8,88(sp)
aaaade94:	05912a23          	sw	s9,84(sp)
aaaade98:	04f10723          	sb	a5,78(sp)
aaaade9c:	00c12703          	lw	a4,12(sp)
aaaadea0:	41085813          	srai	a6,a6,0x10
aaaadea4:	04031a63          	bnez	t1,aaaadef8 <main+0xc8>
aaaadea8:	2c071ae3          	bnez	a4,aaaae97c <main+0xb4c>
aaaadeac:	00081463          	bnez	a6,aaaadeb4 <main+0x84>
aaaadeb0:	4a50106f          	j	aaaafb54 <main+0x1d24>
aaaadeb4:	00200713          	li	a4,2
aaaadeb8:	00070a13          	mv	s4,a4
aaaadebc:	29a00893          	li	a7,666
aaaadec0:	00700313          	li	t1,7
aaaadec4:	00100793          	li	a5,1
aaaadec8:	00003f17          	auipc	t5,0x3
aaaadecc:	138f0f13          	addi	t5,t5,312 # aaab1000 <static_memblk>
aaaaded0:	01e12c23          	sw	t5,24(sp)
aaaaded4:	000a0463          	beqz	s4,aaaadedc <main+0xac>
aaaaded8:	4490106f          	j	aaaafb20 <main+0x1cf0>
aaaadedc:	03170fb3          	mul	t6,a4,a7
aaaadee0:	00c11e83          	lh	t4,12(sp)
aaaadee4:	fff88293          	addi	t0,a7,-1
aaaadee8:	00400393          	li	t2,4
aaaadeec:	01ff0fb3          	add	t6,t5,t6
aaaadef0:	03f12023          	sw	t6,32(sp)
aaaadef4:	5100106f          	j	aaaaf404 <main+0x15d4>
aaaadef8:	260718e3          	bnez	a4,aaaae968 <main+0xb38>
aaaadefc:	00081463          	bnez	a6,aaaadf04 <main+0xd4>
aaaadf00:	4d80106f          	j	aaaaf3d8 <main+0x15a8>
aaaadf04:	00137693          	andi	a3,t1,1
aaaadf08:	00237a13          	andi	s4,t1,2
aaaadf0c:	00068793          	mv	a5,a3
aaaadf10:	00437393          	andi	t2,t1,4
aaaadf14:	000a0463          	beqz	s4,aaaadf1c <main+0xec>
aaaadf18:	0c10106f          	j	aaaaf7d8 <main+0x19a8>
aaaadf1c:	00038463          	beqz	t2,aaaadf24 <main+0xf4>
aaaadf20:	3cd0106f          	j	aaaafaec <main+0x1cbc>
aaaadf24:	00068463          	beqz	a3,aaaadf2c <main+0xfc>
aaaadf28:	4c00106f          	j	aaaaf3e8 <main+0x15b8>
aaaadf2c:	7d000893          	li	a7,2000
aaaadf30:	00003f17          	auipc	t5,0x3
aaaadf34:	0d0f0f13          	addi	t5,t5,208 # aaab1000 <static_memblk>
aaaadf38:	24041ae3          	bnez	s0,aaaae98c <main+0xb5c>
aaaadf3c:	ffffa437          	lui	s0,0xffffa
aaaadf40:	00140413          	addi	s0,s0,1 # ffffa001 <_stack_top+0xfffa001>
aaaadf44:	00000e13          	li	t3,0
aaaadf48:	00100e93          	li	t4,1
aaaadf4c:	00003617          	auipc	a2,0x3
aaaadf50:	0b460613          	addi	a2,a2,180 # aaab1000 <static_memblk>
aaaadf54:	00c10493          	addi	s1,sp,12
aaaadf58:	002e9913          	slli	s2,t4,0x2
aaaadf5c:	01d90933          	add	s2,s2,t4
aaaadf60:	00191913          	slli	s2,s2,0x1
aaaadf64:	00102013          	slti	zero,zero,1
aaaadf68:	00302013          	slti	zero,zero,3
aaaadf6c:	00000e93          	li	t4,0
aaaadf70:	1e0906e3          	beqz	s2,aaaae95c <main+0xb2c>
aaaadf74:	00100593          	li	a1,1
aaaadf78:	00048513          	mv	a0,s1
aaaadf7c:	01011823          	sh	a6,16(sp)
aaaadf80:	00c12a23          	sw	a2,20(sp)
aaaadf84:	03112223          	sw	a7,36(sp)
aaaadf88:	02612623          	sw	t1,44(sp)
aaaadf8c:	05c11623          	sh	t3,76(sp)
aaaadf90:	03212423          	sw	s2,40(sp)
aaaadf94:	04012223          	sw	zero,68(sp)
aaaadf98:	04012423          	sw	zero,72(sp)
aaaadf9c:	fffff097          	auipc	ra,0xfffff
aaaadfa0:	3ec080e7          	jalr	1004(ra) # aaaad388 <core_bench_list>
aaaadfa4:	04415703          	lhu	a4,68(sp)
aaaadfa8:	0ff57593          	zext.b	a1,a0
aaaadfac:	0025d893          	srli	a7,a1,0x2
aaaadfb0:	00e5c7b3          	xor	a5,a1,a4
aaaadfb4:	0017f793          	andi	a5,a5,1
aaaadfb8:	40f007b3          	neg	a5,a5
aaaadfbc:	00175713          	srli	a4,a4,0x1
aaaadfc0:	0087f7b3          	and	a5,a5,s0
aaaadfc4:	00e7c7b3          	xor	a5,a5,a4
aaaadfc8:	01079793          	slli	a5,a5,0x10
aaaadfcc:	0107d793          	srli	a5,a5,0x10
aaaadfd0:	0015d713          	srli	a4,a1,0x1
aaaadfd4:	00f74733          	xor	a4,a4,a5
aaaadfd8:	00177713          	andi	a4,a4,1
aaaadfdc:	40e00733          	neg	a4,a4
aaaadfe0:	0017d793          	srli	a5,a5,0x1
aaaadfe4:	00877733          	and	a4,a4,s0
aaaadfe8:	00f74733          	xor	a4,a4,a5
aaaadfec:	01071713          	slli	a4,a4,0x10
aaaadff0:	01075713          	srli	a4,a4,0x10
aaaadff4:	00e8c8b3          	xor	a7,a7,a4
aaaadff8:	0018f893          	andi	a7,a7,1
aaaadffc:	411008b3          	neg	a7,a7
aaaae000:	00175713          	srli	a4,a4,0x1
aaaae004:	0088f8b3          	and	a7,a7,s0
aaaae008:	00e8c8b3          	xor	a7,a7,a4
aaaae00c:	01089893          	slli	a7,a7,0x10
aaaae010:	0035d813          	srli	a6,a1,0x3
aaaae014:	0108d893          	srli	a7,a7,0x10
aaaae018:	01184833          	xor	a6,a6,a7
aaaae01c:	00187813          	andi	a6,a6,1
aaaae020:	41000833          	neg	a6,a6
aaaae024:	0018d893          	srli	a7,a7,0x1
aaaae028:	00887833          	and	a6,a6,s0
aaaae02c:	01184833          	xor	a6,a6,a7
aaaae030:	01081813          	slli	a6,a6,0x10
aaaae034:	0045d613          	srli	a2,a1,0x4
aaaae038:	01085813          	srli	a6,a6,0x10
aaaae03c:	01064633          	xor	a2,a2,a6
aaaae040:	00167613          	andi	a2,a2,1
aaaae044:	40c00633          	neg	a2,a2
aaaae048:	00185813          	srli	a6,a6,0x1
aaaae04c:	00867633          	and	a2,a2,s0
aaaae050:	01064633          	xor	a2,a2,a6
aaaae054:	01061613          	slli	a2,a2,0x10
aaaae058:	0055d693          	srli	a3,a1,0x5
aaaae05c:	01065613          	srli	a2,a2,0x10
aaaae060:	00c6c6b3          	xor	a3,a3,a2
aaaae064:	0016f693          	andi	a3,a3,1
aaaae068:	40d006b3          	neg	a3,a3
aaaae06c:	00165613          	srli	a2,a2,0x1
aaaae070:	0086f6b3          	and	a3,a3,s0
aaaae074:	00c6c6b3          	xor	a3,a3,a2
aaaae078:	01069693          	slli	a3,a3,0x10
aaaae07c:	0065d713          	srli	a4,a1,0x6
aaaae080:	0106d693          	srli	a3,a3,0x10
aaaae084:	00d74733          	xor	a4,a4,a3
aaaae088:	00177713          	andi	a4,a4,1
aaaae08c:	40e00733          	neg	a4,a4
aaaae090:	0016d693          	srli	a3,a3,0x1
aaaae094:	00877733          	and	a4,a4,s0
aaaae098:	00d74733          	xor	a4,a4,a3
aaaae09c:	01071713          	slli	a4,a4,0x10
aaaae0a0:	01075713          	srli	a4,a4,0x10
aaaae0a4:	0075d593          	srli	a1,a1,0x7
aaaae0a8:	00e5c5b3          	xor	a1,a1,a4
aaaae0ac:	0015f593          	andi	a1,a1,1
aaaae0b0:	40b005b3          	neg	a1,a1
aaaae0b4:	00175713          	srli	a4,a4,0x1
aaaae0b8:	0085f5b3          	and	a1,a1,s0
aaaae0bc:	00e5c5b3          	xor	a1,a1,a4
aaaae0c0:	00855793          	srli	a5,a0,0x8
aaaae0c4:	01059593          	slli	a1,a1,0x10
aaaae0c8:	0ff7f793          	zext.b	a5,a5
aaaae0cc:	0105d593          	srli	a1,a1,0x10
aaaae0d0:	0027de13          	srli	t3,a5,0x2
aaaae0d4:	0047d813          	srli	a6,a5,0x4
aaaae0d8:	0077d613          	srli	a2,a5,0x7
aaaae0dc:	0067d713          	srli	a4,a5,0x6
aaaae0e0:	0017d313          	srli	t1,a5,0x1
aaaae0e4:	0037d893          	srli	a7,a5,0x3
aaaae0e8:	0057d693          	srli	a3,a5,0x5
aaaae0ec:	00b7c7b3          	xor	a5,a5,a1
aaaae0f0:	0017f793          	andi	a5,a5,1
aaaae0f4:	40f007b3          	neg	a5,a5
aaaae0f8:	0015d593          	srli	a1,a1,0x1
aaaae0fc:	0087f7b3          	and	a5,a5,s0
aaaae100:	00b7c7b3          	xor	a5,a5,a1
aaaae104:	01079793          	slli	a5,a5,0x10
aaaae108:	0107d793          	srli	a5,a5,0x10
aaaae10c:	00f34333          	xor	t1,t1,a5
aaaae110:	00137313          	andi	t1,t1,1
aaaae114:	40600333          	neg	t1,t1
aaaae118:	0017d793          	srli	a5,a5,0x1
aaaae11c:	00837333          	and	t1,t1,s0
aaaae120:	00f34333          	xor	t1,t1,a5
aaaae124:	01031313          	slli	t1,t1,0x10
aaaae128:	01035313          	srli	t1,t1,0x10
aaaae12c:	006e47b3          	xor	a5,t3,t1
aaaae130:	0017f793          	andi	a5,a5,1
aaaae134:	40f007b3          	neg	a5,a5
aaaae138:	00135313          	srli	t1,t1,0x1
aaaae13c:	0087f7b3          	and	a5,a5,s0
aaaae140:	0067c7b3          	xor	a5,a5,t1
aaaae144:	01079793          	slli	a5,a5,0x10
aaaae148:	0107d793          	srli	a5,a5,0x10
aaaae14c:	00f8c8b3          	xor	a7,a7,a5
aaaae150:	0018f893          	andi	a7,a7,1
aaaae154:	411008b3          	neg	a7,a7
aaaae158:	0017d793          	srli	a5,a5,0x1
aaaae15c:	0088f8b3          	and	a7,a7,s0
aaaae160:	00f8c8b3          	xor	a7,a7,a5
aaaae164:	01089893          	slli	a7,a7,0x10
aaaae168:	0108d893          	srli	a7,a7,0x10
aaaae16c:	011847b3          	xor	a5,a6,a7
aaaae170:	0017f793          	andi	a5,a5,1
aaaae174:	40f007b3          	neg	a5,a5
aaaae178:	0018d893          	srli	a7,a7,0x1
aaaae17c:	0087f7b3          	and	a5,a5,s0
aaaae180:	0117c7b3          	xor	a5,a5,a7
aaaae184:	01079793          	slli	a5,a5,0x10
aaaae188:	0107d793          	srli	a5,a5,0x10
aaaae18c:	00f6c6b3          	xor	a3,a3,a5
aaaae190:	0016f693          	andi	a3,a3,1
aaaae194:	40d006b3          	neg	a3,a3
aaaae198:	0017d793          	srli	a5,a5,0x1
aaaae19c:	0086f6b3          	and	a3,a3,s0
aaaae1a0:	00f6c6b3          	xor	a3,a3,a5
aaaae1a4:	01069693          	slli	a3,a3,0x10
aaaae1a8:	0106d693          	srli	a3,a3,0x10
aaaae1ac:	00d747b3          	xor	a5,a4,a3
aaaae1b0:	0017f793          	andi	a5,a5,1
aaaae1b4:	40f007b3          	neg	a5,a5
aaaae1b8:	0016d693          	srli	a3,a3,0x1
aaaae1bc:	0087f7b3          	and	a5,a5,s0
aaaae1c0:	00d7c7b3          	xor	a5,a5,a3
aaaae1c4:	01079793          	slli	a5,a5,0x10
aaaae1c8:	0107d793          	srli	a5,a5,0x10
aaaae1cc:	00f64733          	xor	a4,a2,a5
aaaae1d0:	00177713          	andi	a4,a4,1
aaaae1d4:	40e00733          	neg	a4,a4
aaaae1d8:	00877733          	and	a4,a4,s0
aaaae1dc:	0017d793          	srli	a5,a5,0x1
aaaae1e0:	00f747b3          	xor	a5,a4,a5
aaaae1e4:	fff00593          	li	a1,-1
aaaae1e8:	00048513          	mv	a0,s1
aaaae1ec:	04f11223          	sh	a5,68(sp)
aaaae1f0:	fffff097          	auipc	ra,0xfffff
aaaae1f4:	198080e7          	jalr	408(ra) # aaaad388 <core_bench_list>
aaaae1f8:	04415783          	lhu	a5,68(sp)
aaaae1fc:	0ff57613          	zext.b	a2,a0
aaaae200:	00265893          	srli	a7,a2,0x2
aaaae204:	00f64733          	xor	a4,a2,a5
aaaae208:	00177713          	andi	a4,a4,1
aaaae20c:	40e00733          	neg	a4,a4
aaaae210:	0017d793          	srli	a5,a5,0x1
aaaae214:	00877733          	and	a4,a4,s0
aaaae218:	00f74733          	xor	a4,a4,a5
aaaae21c:	01071713          	slli	a4,a4,0x10
aaaae220:	01075713          	srli	a4,a4,0x10
aaaae224:	00165793          	srli	a5,a2,0x1
aaaae228:	00e7c7b3          	xor	a5,a5,a4
aaaae22c:	0017f793          	andi	a5,a5,1
aaaae230:	40f007b3          	neg	a5,a5
aaaae234:	00175713          	srli	a4,a4,0x1
aaaae238:	0087f7b3          	and	a5,a5,s0
aaaae23c:	00e7c7b3          	xor	a5,a5,a4
aaaae240:	01079793          	slli	a5,a5,0x10
aaaae244:	0107d793          	srli	a5,a5,0x10
aaaae248:	00f8c8b3          	xor	a7,a7,a5
aaaae24c:	0018f893          	andi	a7,a7,1
aaaae250:	411008b3          	neg	a7,a7
aaaae254:	0017d793          	srli	a5,a5,0x1
aaaae258:	0088f8b3          	and	a7,a7,s0
aaaae25c:	00f8c8b3          	xor	a7,a7,a5
aaaae260:	01089893          	slli	a7,a7,0x10
aaaae264:	00365813          	srli	a6,a2,0x3
aaaae268:	0108d893          	srli	a7,a7,0x10
aaaae26c:	01184833          	xor	a6,a6,a7
aaaae270:	00187813          	andi	a6,a6,1
aaaae274:	41000833          	neg	a6,a6
aaaae278:	0018d893          	srli	a7,a7,0x1
aaaae27c:	00887833          	and	a6,a6,s0
aaaae280:	01184833          	xor	a6,a6,a7
aaaae284:	01081813          	slli	a6,a6,0x10
aaaae288:	00465593          	srli	a1,a2,0x4
aaaae28c:	01085813          	srli	a6,a6,0x10
aaaae290:	0105c5b3          	xor	a1,a1,a6
aaaae294:	0015f593          	andi	a1,a1,1
aaaae298:	40b005b3          	neg	a1,a1
aaaae29c:	00185813          	srli	a6,a6,0x1
aaaae2a0:	0085f5b3          	and	a1,a1,s0
aaaae2a4:	0105c5b3          	xor	a1,a1,a6
aaaae2a8:	01059593          	slli	a1,a1,0x10
aaaae2ac:	00565693          	srli	a3,a2,0x5
aaaae2b0:	0105d593          	srli	a1,a1,0x10
aaaae2b4:	00b6c6b3          	xor	a3,a3,a1
aaaae2b8:	0016f693          	andi	a3,a3,1
aaaae2bc:	40d006b3          	neg	a3,a3
aaaae2c0:	0015d593          	srli	a1,a1,0x1
aaaae2c4:	0086f6b3          	and	a3,a3,s0
aaaae2c8:	00b6c6b3          	xor	a3,a3,a1
aaaae2cc:	01069693          	slli	a3,a3,0x10
aaaae2d0:	00665793          	srli	a5,a2,0x6
aaaae2d4:	0106d693          	srli	a3,a3,0x10
aaaae2d8:	00d7c7b3          	xor	a5,a5,a3
aaaae2dc:	0017f793          	andi	a5,a5,1
aaaae2e0:	40f007b3          	neg	a5,a5
aaaae2e4:	0016d693          	srli	a3,a3,0x1
aaaae2e8:	0087f7b3          	and	a5,a5,s0
aaaae2ec:	00d7c7b3          	xor	a5,a5,a3
aaaae2f0:	01079793          	slli	a5,a5,0x10
aaaae2f4:	0107d793          	srli	a5,a5,0x10
aaaae2f8:	00765613          	srli	a2,a2,0x7
aaaae2fc:	00f64633          	xor	a2,a2,a5
aaaae300:	00167613          	andi	a2,a2,1
aaaae304:	40c00633          	neg	a2,a2
aaaae308:	0017d793          	srli	a5,a5,0x1
aaaae30c:	00867633          	and	a2,a2,s0
aaaae310:	00f64633          	xor	a2,a2,a5
aaaae314:	00855713          	srli	a4,a0,0x8
aaaae318:	01061613          	slli	a2,a2,0x10
aaaae31c:	0ff77713          	zext.b	a4,a4
aaaae320:	01065613          	srli	a2,a2,0x10
aaaae324:	00275313          	srli	t1,a4,0x2
aaaae328:	00175e13          	srli	t3,a4,0x1
aaaae32c:	00375f93          	srli	t6,a4,0x3
aaaae330:	00475513          	srli	a0,a4,0x4
aaaae334:	00575593          	srli	a1,a4,0x5
aaaae338:	00675693          	srli	a3,a4,0x6
aaaae33c:	00775793          	srli	a5,a4,0x7
aaaae340:	00c74733          	xor	a4,a4,a2
aaaae344:	00177713          	andi	a4,a4,1
aaaae348:	40e00733          	neg	a4,a4
aaaae34c:	00165613          	srli	a2,a2,0x1
aaaae350:	00877733          	and	a4,a4,s0
aaaae354:	00c74733          	xor	a4,a4,a2
aaaae358:	01071713          	slli	a4,a4,0x10
aaaae35c:	01075713          	srli	a4,a4,0x10
aaaae360:	00ee4e33          	xor	t3,t3,a4
aaaae364:	001e7e13          	andi	t3,t3,1
aaaae368:	41c00e33          	neg	t3,t3
aaaae36c:	00175713          	srli	a4,a4,0x1
aaaae370:	008e7e33          	and	t3,t3,s0
aaaae374:	00ee4e33          	xor	t3,t3,a4
aaaae378:	010e1e13          	slli	t3,t3,0x10
aaaae37c:	010e5e13          	srli	t3,t3,0x10
aaaae380:	01c34733          	xor	a4,t1,t3
aaaae384:	00177713          	andi	a4,a4,1
aaaae388:	40e00733          	neg	a4,a4
aaaae38c:	001e5e13          	srli	t3,t3,0x1
aaaae390:	00877733          	and	a4,a4,s0
aaaae394:	01c74733          	xor	a4,a4,t3
aaaae398:	01071713          	slli	a4,a4,0x10
aaaae39c:	01075713          	srli	a4,a4,0x10
aaaae3a0:	00efcfb3          	xor	t6,t6,a4
aaaae3a4:	001fff93          	andi	t6,t6,1
aaaae3a8:	41f00fb3          	neg	t6,t6
aaaae3ac:	00175713          	srli	a4,a4,0x1
aaaae3b0:	008fffb3          	and	t6,t6,s0
aaaae3b4:	00efcfb3          	xor	t6,t6,a4
aaaae3b8:	010f9f93          	slli	t6,t6,0x10
aaaae3bc:	010fdf93          	srli	t6,t6,0x10
aaaae3c0:	00100993          	li	s3,1
aaaae3c4:	01f54733          	xor	a4,a0,t6
aaaae3c8:	01377733          	and	a4,a4,s3
aaaae3cc:	40e00733          	neg	a4,a4
aaaae3d0:	001fdf93          	srli	t6,t6,0x1
aaaae3d4:	00877733          	and	a4,a4,s0
aaaae3d8:	01f74733          	xor	a4,a4,t6
aaaae3dc:	01071713          	slli	a4,a4,0x10
aaaae3e0:	01075713          	srli	a4,a4,0x10
aaaae3e4:	00e5c5b3          	xor	a1,a1,a4
aaaae3e8:	0135f5b3          	and	a1,a1,s3
aaaae3ec:	40b005b3          	neg	a1,a1
aaaae3f0:	00175713          	srli	a4,a4,0x1
aaaae3f4:	0085f5b3          	and	a1,a1,s0
aaaae3f8:	00e5c5b3          	xor	a1,a1,a4
aaaae3fc:	01059593          	slli	a1,a1,0x10
aaaae400:	0105d593          	srli	a1,a1,0x10
aaaae404:	00b6c733          	xor	a4,a3,a1
aaaae408:	01377733          	and	a4,a4,s3
aaaae40c:	40e00733          	neg	a4,a4
aaaae410:	00877733          	and	a4,a4,s0
aaaae414:	0015d593          	srli	a1,a1,0x1
aaaae418:	00b74733          	xor	a4,a4,a1
aaaae41c:	01071713          	slli	a4,a4,0x10
aaaae420:	01075713          	srli	a4,a4,0x10
aaaae424:	00e7c7b3          	xor	a5,a5,a4
aaaae428:	0137f7b3          	and	a5,a5,s3
aaaae42c:	40f007b3          	neg	a5,a5
aaaae430:	0087f7b3          	and	a5,a5,s0
aaaae434:	00175713          	srli	a4,a4,0x1
aaaae438:	00e7c7b3          	xor	a5,a5,a4
aaaae43c:	01079793          	slli	a5,a5,0x10
aaaae440:	01011803          	lh	a6,16(sp)
aaaae444:	01412603          	lw	a2,20(sp)
aaaae448:	02412883          	lw	a7,36(sp)
aaaae44c:	02812e83          	lw	t4,40(sp)
aaaae450:	02c12303          	lw	t1,44(sp)
aaaae454:	04812f03          	lw	t5,72(sp)
aaaae458:	04c11e03          	lh	t3,76(sp)
aaaae45c:	0107d793          	srli	a5,a5,0x10
aaaae460:	00078f93          	mv	t6,a5
aaaae464:	00100593          	li	a1,1
aaaae468:	00048513          	mv	a0,s1
aaaae46c:	03d12423          	sw	t4,40(sp)
aaaae470:	05f11323          	sh	t6,70(sp)
aaaae474:	05e12423          	sw	t5,72(sp)
aaaae478:	01011823          	sh	a6,16(sp)
aaaae47c:	00c12a23          	sw	a2,20(sp)
aaaae480:	03112223          	sw	a7,36(sp)
aaaae484:	02612623          	sw	t1,44(sp)
aaaae488:	04f11223          	sh	a5,68(sp)
aaaae48c:	05c11623          	sh	t3,76(sp)
aaaae490:	fffff097          	auipc	ra,0xfffff
aaaae494:	ef8080e7          	jalr	-264(ra) # aaaad388 <core_bench_list>
aaaae498:	04415783          	lhu	a5,68(sp)
aaaae49c:	0ff57593          	zext.b	a1,a0
aaaae4a0:	0025d813          	srli	a6,a1,0x2
aaaae4a4:	00f5c733          	xor	a4,a1,a5
aaaae4a8:	00177713          	andi	a4,a4,1
aaaae4ac:	40e00733          	neg	a4,a4
aaaae4b0:	0017d793          	srli	a5,a5,0x1
aaaae4b4:	00877733          	and	a4,a4,s0
aaaae4b8:	00f74733          	xor	a4,a4,a5
aaaae4bc:	01071713          	slli	a4,a4,0x10
aaaae4c0:	01075713          	srli	a4,a4,0x10
aaaae4c4:	0015d793          	srli	a5,a1,0x1
aaaae4c8:	00e7c7b3          	xor	a5,a5,a4
aaaae4cc:	0017f793          	andi	a5,a5,1
aaaae4d0:	40f007b3          	neg	a5,a5
aaaae4d4:	00175713          	srli	a4,a4,0x1
aaaae4d8:	0087f7b3          	and	a5,a5,s0
aaaae4dc:	00e7c7b3          	xor	a5,a5,a4
aaaae4e0:	01079793          	slli	a5,a5,0x10
aaaae4e4:	0107d793          	srli	a5,a5,0x10
aaaae4e8:	00f84833          	xor	a6,a6,a5
aaaae4ec:	00187813          	andi	a6,a6,1
aaaae4f0:	41000833          	neg	a6,a6
aaaae4f4:	0017d793          	srli	a5,a5,0x1
aaaae4f8:	00887833          	and	a6,a6,s0
aaaae4fc:	00f84833          	xor	a6,a6,a5
aaaae500:	01081813          	slli	a6,a6,0x10
aaaae504:	0035d613          	srli	a2,a1,0x3
aaaae508:	01085813          	srli	a6,a6,0x10
aaaae50c:	01064633          	xor	a2,a2,a6
aaaae510:	00167613          	andi	a2,a2,1
aaaae514:	40c00633          	neg	a2,a2
aaaae518:	00185813          	srli	a6,a6,0x1
aaaae51c:	00867633          	and	a2,a2,s0
aaaae520:	01064633          	xor	a2,a2,a6
aaaae524:	01061613          	slli	a2,a2,0x10
aaaae528:	0045d693          	srli	a3,a1,0x4
aaaae52c:	01065613          	srli	a2,a2,0x10
aaaae530:	00c6c6b3          	xor	a3,a3,a2
aaaae534:	0016f693          	andi	a3,a3,1
aaaae538:	40d006b3          	neg	a3,a3
aaaae53c:	00165613          	srli	a2,a2,0x1
aaaae540:	0086f6b3          	and	a3,a3,s0
aaaae544:	00c6c6b3          	xor	a3,a3,a2
aaaae548:	01069693          	slli	a3,a3,0x10
aaaae54c:	0055d713          	srli	a4,a1,0x5
aaaae550:	0106d693          	srli	a3,a3,0x10
aaaae554:	00d74733          	xor	a4,a4,a3
aaaae558:	00177713          	andi	a4,a4,1
aaaae55c:	40e00733          	neg	a4,a4
aaaae560:	0016d693          	srli	a3,a3,0x1
aaaae564:	00877733          	and	a4,a4,s0
aaaae568:	00d74733          	xor	a4,a4,a3
aaaae56c:	01071713          	slli	a4,a4,0x10
aaaae570:	0065d793          	srli	a5,a1,0x6
aaaae574:	01075713          	srli	a4,a4,0x10
aaaae578:	00e7c7b3          	xor	a5,a5,a4
aaaae57c:	0017f793          	andi	a5,a5,1
aaaae580:	40f007b3          	neg	a5,a5
aaaae584:	00175713          	srli	a4,a4,0x1
aaaae588:	0087f7b3          	and	a5,a5,s0
aaaae58c:	00e7c7b3          	xor	a5,a5,a4
aaaae590:	01079793          	slli	a5,a5,0x10
aaaae594:	0107d793          	srli	a5,a5,0x10
aaaae598:	0075d593          	srli	a1,a1,0x7
aaaae59c:	00f5c5b3          	xor	a1,a1,a5
aaaae5a0:	0015f593          	andi	a1,a1,1
aaaae5a4:	40b005b3          	neg	a1,a1
aaaae5a8:	0017d793          	srli	a5,a5,0x1
aaaae5ac:	0085f5b3          	and	a1,a1,s0
aaaae5b0:	00f5c5b3          	xor	a1,a1,a5
aaaae5b4:	00855513          	srli	a0,a0,0x8
aaaae5b8:	01059593          	slli	a1,a1,0x10
aaaae5bc:	0ff57513          	zext.b	a0,a0
aaaae5c0:	0105d593          	srli	a1,a1,0x10
aaaae5c4:	00b547b3          	xor	a5,a0,a1
aaaae5c8:	0017f793          	andi	a5,a5,1
aaaae5cc:	40f007b3          	neg	a5,a5
aaaae5d0:	0015d593          	srli	a1,a1,0x1
aaaae5d4:	0087f7b3          	and	a5,a5,s0
aaaae5d8:	00b7c7b3          	xor	a5,a5,a1
aaaae5dc:	01079793          	slli	a5,a5,0x10
aaaae5e0:	00155313          	srli	t1,a0,0x1
aaaae5e4:	0107d793          	srli	a5,a5,0x10
aaaae5e8:	00f34333          	xor	t1,t1,a5
aaaae5ec:	00137313          	andi	t1,t1,1
aaaae5f0:	40600333          	neg	t1,t1
aaaae5f4:	0017d793          	srli	a5,a5,0x1
aaaae5f8:	00837333          	and	t1,t1,s0
aaaae5fc:	00f34333          	xor	t1,t1,a5
aaaae600:	01031313          	slli	t1,t1,0x10
aaaae604:	00255e13          	srli	t3,a0,0x2
aaaae608:	01035313          	srli	t1,t1,0x10
aaaae60c:	006e47b3          	xor	a5,t3,t1
aaaae610:	0017f793          	andi	a5,a5,1
aaaae614:	40f007b3          	neg	a5,a5
aaaae618:	00135313          	srli	t1,t1,0x1
aaaae61c:	0087f7b3          	and	a5,a5,s0
aaaae620:	0067c7b3          	xor	a5,a5,t1
aaaae624:	01079793          	slli	a5,a5,0x10
aaaae628:	00355893          	srli	a7,a0,0x3
aaaae62c:	0107d793          	srli	a5,a5,0x10
aaaae630:	00f8c8b3          	xor	a7,a7,a5
aaaae634:	0018f893          	andi	a7,a7,1
aaaae638:	411008b3          	neg	a7,a7
aaaae63c:	0017d793          	srli	a5,a5,0x1
aaaae640:	0088f8b3          	and	a7,a7,s0
aaaae644:	00f8c8b3          	xor	a7,a7,a5
aaaae648:	01089893          	slli	a7,a7,0x10
aaaae64c:	00455813          	srli	a6,a0,0x4
aaaae650:	0108d893          	srli	a7,a7,0x10
aaaae654:	011847b3          	xor	a5,a6,a7
aaaae658:	0017f793          	andi	a5,a5,1
aaaae65c:	40f007b3          	neg	a5,a5
aaaae660:	0018d893          	srli	a7,a7,0x1
aaaae664:	0087f7b3          	and	a5,a5,s0
aaaae668:	0117c7b3          	xor	a5,a5,a7
aaaae66c:	01079793          	slli	a5,a5,0x10
aaaae670:	00555693          	srli	a3,a0,0x5
aaaae674:	0107d793          	srli	a5,a5,0x10
aaaae678:	00f6c6b3          	xor	a3,a3,a5
aaaae67c:	0016f693          	andi	a3,a3,1
aaaae680:	40d006b3          	neg	a3,a3
aaaae684:	0017d793          	srli	a5,a5,0x1
aaaae688:	0086f6b3          	and	a3,a3,s0
aaaae68c:	00f6c6b3          	xor	a3,a3,a5
aaaae690:	01069693          	slli	a3,a3,0x10
aaaae694:	00655713          	srli	a4,a0,0x6
aaaae698:	0106d693          	srli	a3,a3,0x10
aaaae69c:	00d747b3          	xor	a5,a4,a3
aaaae6a0:	0017f793          	andi	a5,a5,1
aaaae6a4:	40f007b3          	neg	a5,a5
aaaae6a8:	0016d693          	srli	a3,a3,0x1
aaaae6ac:	0087f7b3          	and	a5,a5,s0
aaaae6b0:	00d7c7b3          	xor	a5,a5,a3
aaaae6b4:	01079793          	slli	a5,a5,0x10
aaaae6b8:	00755613          	srli	a2,a0,0x7
aaaae6bc:	0107d793          	srli	a5,a5,0x10
aaaae6c0:	00f64733          	xor	a4,a2,a5
aaaae6c4:	00177713          	andi	a4,a4,1
aaaae6c8:	40e00733          	neg	a4,a4
aaaae6cc:	00877733          	and	a4,a4,s0
aaaae6d0:	0017d793          	srli	a5,a5,0x1
aaaae6d4:	00f747b3          	xor	a5,a4,a5
aaaae6d8:	fff00593          	li	a1,-1
aaaae6dc:	00048513          	mv	a0,s1
aaaae6e0:	04f11223          	sh	a5,68(sp)
aaaae6e4:	fffff097          	auipc	ra,0xfffff
aaaae6e8:	ca4080e7          	jalr	-860(ra) # aaaad388 <core_bench_list>
aaaae6ec:	04415783          	lhu	a5,68(sp)
aaaae6f0:	0ff57813          	zext.b	a6,a0
aaaae6f4:	00285593          	srli	a1,a6,0x2
aaaae6f8:	00f84733          	xor	a4,a6,a5
aaaae6fc:	00177713          	andi	a4,a4,1
aaaae700:	40e00733          	neg	a4,a4
aaaae704:	0017d793          	srli	a5,a5,0x1
aaaae708:	00877733          	and	a4,a4,s0
aaaae70c:	00f74733          	xor	a4,a4,a5
aaaae710:	01071713          	slli	a4,a4,0x10
aaaae714:	01075713          	srli	a4,a4,0x10
aaaae718:	00185793          	srli	a5,a6,0x1
aaaae71c:	00e7c7b3          	xor	a5,a5,a4
aaaae720:	0017f793          	andi	a5,a5,1
aaaae724:	40f007b3          	neg	a5,a5
aaaae728:	00175713          	srli	a4,a4,0x1
aaaae72c:	0087f7b3          	and	a5,a5,s0
aaaae730:	00e7c7b3          	xor	a5,a5,a4
aaaae734:	01079793          	slli	a5,a5,0x10
aaaae738:	0107d793          	srli	a5,a5,0x10
aaaae73c:	00f5c5b3          	xor	a1,a1,a5
aaaae740:	0015f593          	andi	a1,a1,1
aaaae744:	40b005b3          	neg	a1,a1
aaaae748:	0017d793          	srli	a5,a5,0x1
aaaae74c:	0085f5b3          	and	a1,a1,s0
aaaae750:	00f5c5b3          	xor	a1,a1,a5
aaaae754:	01059593          	slli	a1,a1,0x10
aaaae758:	00385613          	srli	a2,a6,0x3
aaaae75c:	0105d593          	srli	a1,a1,0x10
aaaae760:	00b64633          	xor	a2,a2,a1
aaaae764:	00167613          	andi	a2,a2,1
aaaae768:	40c00633          	neg	a2,a2
aaaae76c:	0015d593          	srli	a1,a1,0x1
aaaae770:	00867633          	and	a2,a2,s0
aaaae774:	00b64633          	xor	a2,a2,a1
aaaae778:	01061613          	slli	a2,a2,0x10
aaaae77c:	00485693          	srli	a3,a6,0x4
aaaae780:	01065613          	srli	a2,a2,0x10
aaaae784:	00c6c6b3          	xor	a3,a3,a2
aaaae788:	0016f693          	andi	a3,a3,1
aaaae78c:	40d006b3          	neg	a3,a3
aaaae790:	00165613          	srli	a2,a2,0x1
aaaae794:	0086f6b3          	and	a3,a3,s0
aaaae798:	00c6c6b3          	xor	a3,a3,a2
aaaae79c:	01069693          	slli	a3,a3,0x10
aaaae7a0:	00585713          	srli	a4,a6,0x5
aaaae7a4:	0106d693          	srli	a3,a3,0x10
aaaae7a8:	00d74733          	xor	a4,a4,a3
aaaae7ac:	00177713          	andi	a4,a4,1
aaaae7b0:	40e00733          	neg	a4,a4
aaaae7b4:	0016d693          	srli	a3,a3,0x1
aaaae7b8:	00877733          	and	a4,a4,s0
aaaae7bc:	00d74733          	xor	a4,a4,a3
aaaae7c0:	01071713          	slli	a4,a4,0x10
aaaae7c4:	00685793          	srli	a5,a6,0x6
aaaae7c8:	01075713          	srli	a4,a4,0x10
aaaae7cc:	00e7c7b3          	xor	a5,a5,a4
aaaae7d0:	0017f793          	andi	a5,a5,1
aaaae7d4:	40f007b3          	neg	a5,a5
aaaae7d8:	00175713          	srli	a4,a4,0x1
aaaae7dc:	0087f7b3          	and	a5,a5,s0
aaaae7e0:	00e7c7b3          	xor	a5,a5,a4
aaaae7e4:	01079793          	slli	a5,a5,0x10
aaaae7e8:	0107d793          	srli	a5,a5,0x10
aaaae7ec:	00785813          	srli	a6,a6,0x7
aaaae7f0:	00f84833          	xor	a6,a6,a5
aaaae7f4:	00187813          	andi	a6,a6,1
aaaae7f8:	41000833          	neg	a6,a6
aaaae7fc:	0017d793          	srli	a5,a5,0x1
aaaae800:	00887833          	and	a6,a6,s0
aaaae804:	00f84833          	xor	a6,a6,a5
aaaae808:	00855513          	srli	a0,a0,0x8
aaaae80c:	01081813          	slli	a6,a6,0x10
aaaae810:	0ff57513          	zext.b	a0,a0
aaaae814:	01085813          	srli	a6,a6,0x10
aaaae818:	010547b3          	xor	a5,a0,a6
aaaae81c:	0017f793          	andi	a5,a5,1
aaaae820:	40f007b3          	neg	a5,a5
aaaae824:	00185813          	srli	a6,a6,0x1
aaaae828:	0087f7b3          	and	a5,a5,s0
aaaae82c:	0107c7b3          	xor	a5,a5,a6
aaaae830:	01079793          	slli	a5,a5,0x10
aaaae834:	00155613          	srli	a2,a0,0x1
aaaae838:	0107d793          	srli	a5,a5,0x10
aaaae83c:	00f64633          	xor	a2,a2,a5
aaaae840:	00167613          	andi	a2,a2,1
aaaae844:	40c00633          	neg	a2,a2
aaaae848:	00867633          	and	a2,a2,s0
aaaae84c:	0017d793          	srli	a5,a5,0x1
aaaae850:	00f647b3          	xor	a5,a2,a5
aaaae854:	01079793          	slli	a5,a5,0x10
aaaae858:	00255313          	srli	t1,a0,0x2
aaaae85c:	0107d793          	srli	a5,a5,0x10
aaaae860:	00355f13          	srli	t5,a0,0x3
aaaae864:	00455e13          	srli	t3,a0,0x4
aaaae868:	00555593          	srli	a1,a0,0x5
aaaae86c:	00655693          	srli	a3,a0,0x6
aaaae870:	00755713          	srli	a4,a0,0x7
aaaae874:	00f34533          	xor	a0,t1,a5
aaaae878:	00157513          	andi	a0,a0,1
aaaae87c:	40a00533          	neg	a0,a0
aaaae880:	0017d793          	srli	a5,a5,0x1
aaaae884:	00857533          	and	a0,a0,s0
aaaae888:	00f54533          	xor	a0,a0,a5
aaaae88c:	01051513          	slli	a0,a0,0x10
aaaae890:	01055513          	srli	a0,a0,0x10
aaaae894:	00af47b3          	xor	a5,t5,a0
aaaae898:	0017f793          	andi	a5,a5,1
aaaae89c:	40f007b3          	neg	a5,a5
aaaae8a0:	00155513          	srli	a0,a0,0x1
aaaae8a4:	0087f7b3          	and	a5,a5,s0
aaaae8a8:	00a7c7b3          	xor	a5,a5,a0
aaaae8ac:	01079793          	slli	a5,a5,0x10
aaaae8b0:	0107d793          	srli	a5,a5,0x10
aaaae8b4:	00fe4533          	xor	a0,t3,a5
aaaae8b8:	00157513          	andi	a0,a0,1
aaaae8bc:	40a00533          	neg	a0,a0
aaaae8c0:	0017d793          	srli	a5,a5,0x1
aaaae8c4:	00857533          	and	a0,a0,s0
aaaae8c8:	00f54533          	xor	a0,a0,a5
aaaae8cc:	01051513          	slli	a0,a0,0x10
aaaae8d0:	01055513          	srli	a0,a0,0x10
aaaae8d4:	00a5c7b3          	xor	a5,a1,a0
aaaae8d8:	0017f793          	andi	a5,a5,1
aaaae8dc:	40f007b3          	neg	a5,a5
aaaae8e0:	0087f7b3          	and	a5,a5,s0
aaaae8e4:	00155513          	srli	a0,a0,0x1
aaaae8e8:	00a7c7b3          	xor	a5,a5,a0
aaaae8ec:	01079793          	slli	a5,a5,0x10
aaaae8f0:	0107d793          	srli	a5,a5,0x10
aaaae8f4:	00f6c6b3          	xor	a3,a3,a5
aaaae8f8:	0016f693          	andi	a3,a3,1
aaaae8fc:	40d006b3          	neg	a3,a3
aaaae900:	0017d793          	srli	a5,a5,0x1
aaaae904:	0086f6b3          	and	a3,a3,s0
aaaae908:	00f6c6b3          	xor	a3,a3,a5
aaaae90c:	01069693          	slli	a3,a3,0x10
aaaae910:	0106d693          	srli	a3,a3,0x10
aaaae914:	00d747b3          	xor	a5,a4,a3
aaaae918:	0017f793          	andi	a5,a5,1
aaaae91c:	40f007b3          	neg	a5,a5
aaaae920:	0087f7b3          	and	a5,a5,s0
aaaae924:	0016d693          	srli	a3,a3,0x1
aaaae928:	00d7c7b3          	xor	a5,a5,a3
aaaae92c:	01079793          	slli	a5,a5,0x10
aaaae930:	00198993          	addi	s3,s3,1
aaaae934:	01011803          	lh	a6,16(sp)
aaaae938:	01412603          	lw	a2,20(sp)
aaaae93c:	02412883          	lw	a7,36(sp)
aaaae940:	02812e83          	lw	t4,40(sp)
aaaae944:	02c12303          	lw	t1,44(sp)
aaaae948:	04615f83          	lhu	t6,70(sp)
aaaae94c:	04812f03          	lw	t5,72(sp)
aaaae950:	04c11e03          	lh	t3,76(sp)
aaaae954:	0107d793          	srli	a5,a5,0x10
aaaae958:	b129e6e3          	bltu	s3,s2,aaaae464 <main+0x634>
aaaae95c:	00402013          	slti	zero,zero,4
aaaae960:	00202013          	slti	zero,zero,2
aaaae964:	df4ff06f          	j	aaaadf58 <main+0x128>
aaaae968:	d8f71e63          	bne	a4,a5,aaaadf04 <main+0xd4>
aaaae96c:	d8081c63          	bnez	a6,aaaadf04 <main+0xd4>
aaaae970:	341537b7          	lui	a5,0x34153
aaaae974:	41578793          	addi	a5,a5,1045 # 34153415 <_start-0x76956beb>
aaaae978:	2650006f          	j	aaaaf3dc <main+0x15ac>
aaaae97c:	00700313          	li	t1,7
aaaae980:	d2f71a63          	bne	a4,a5,aaaadeb4 <main+0x84>
aaaae984:	fe0806e3          	beqz	a6,aaaae970 <main+0xb40>
aaaae988:	d7cff06f          	j	aaaadf04 <main+0xd4>
aaaae98c:	00102013          	slti	zero,zero,1
aaaae990:	00302013          	slti	zero,zero,3
aaaae994:	00c10493          	addi	s1,sp,12
aaaae998:	00100593          	li	a1,1
aaaae99c:	00048513          	mv	a0,s1
aaaae9a0:	01e12a23          	sw	t5,20(sp)
aaaae9a4:	01011823          	sh	a6,16(sp)
aaaae9a8:	03112223          	sw	a7,36(sp)
aaaae9ac:	02612623          	sw	t1,44(sp)
aaaae9b0:	02812423          	sw	s0,40(sp)
aaaae9b4:	04012223          	sw	zero,68(sp)
aaaae9b8:	04012423          	sw	zero,72(sp)
aaaae9bc:	04011623          	sh	zero,76(sp)
aaaae9c0:	fffff097          	auipc	ra,0xfffff
aaaae9c4:	9c8080e7          	jalr	-1592(ra) # aaaad388 <core_bench_list>
aaaae9c8:	04415783          	lhu	a5,68(sp)
aaaae9cc:	0ff57593          	zext.b	a1,a0
aaaae9d0:	ffffa937          	lui	s2,0xffffa
aaaae9d4:	00f5c6b3          	xor	a3,a1,a5
aaaae9d8:	0016f693          	andi	a3,a3,1
aaaae9dc:	00190913          	addi	s2,s2,1 # ffffa001 <_stack_top+0xfffa001>
aaaae9e0:	40d006b3          	neg	a3,a3
aaaae9e4:	0017d793          	srli	a5,a5,0x1
aaaae9e8:	0126f6b3          	and	a3,a3,s2
aaaae9ec:	00f6c6b3          	xor	a3,a3,a5
aaaae9f0:	01069693          	slli	a3,a3,0x10
aaaae9f4:	0106d693          	srli	a3,a3,0x10
aaaae9f8:	0015d713          	srli	a4,a1,0x1
aaaae9fc:	00d74733          	xor	a4,a4,a3
aaaaea00:	00177713          	andi	a4,a4,1
aaaaea04:	40e00733          	neg	a4,a4
aaaaea08:	0016d693          	srli	a3,a3,0x1
aaaaea0c:	01277733          	and	a4,a4,s2
aaaaea10:	00d74733          	xor	a4,a4,a3
aaaaea14:	01071713          	slli	a4,a4,0x10
aaaaea18:	0025d793          	srli	a5,a1,0x2
aaaaea1c:	01075713          	srli	a4,a4,0x10
aaaaea20:	00e7c7b3          	xor	a5,a5,a4
aaaaea24:	0017f793          	andi	a5,a5,1
aaaaea28:	40f007b3          	neg	a5,a5
aaaaea2c:	00175713          	srli	a4,a4,0x1
aaaaea30:	0127f7b3          	and	a5,a5,s2
aaaaea34:	00e7c7b3          	xor	a5,a5,a4
aaaaea38:	01079793          	slli	a5,a5,0x10
aaaaea3c:	00050813          	mv	a6,a0
aaaaea40:	0107d793          	srli	a5,a5,0x10
aaaaea44:	0035d513          	srli	a0,a1,0x3
aaaaea48:	00f54533          	xor	a0,a0,a5
aaaaea4c:	00157513          	andi	a0,a0,1
aaaaea50:	40a00533          	neg	a0,a0
aaaaea54:	0017d793          	srli	a5,a5,0x1
aaaaea58:	01257533          	and	a0,a0,s2
aaaaea5c:	00f54533          	xor	a0,a0,a5
aaaaea60:	01051513          	slli	a0,a0,0x10
aaaaea64:	0045d613          	srli	a2,a1,0x4
aaaaea68:	01055513          	srli	a0,a0,0x10
aaaaea6c:	00a64633          	xor	a2,a2,a0
aaaaea70:	00167613          	andi	a2,a2,1
aaaaea74:	40c00633          	neg	a2,a2
aaaaea78:	00155513          	srli	a0,a0,0x1
aaaaea7c:	01267633          	and	a2,a2,s2
aaaaea80:	00a64633          	xor	a2,a2,a0
aaaaea84:	01061613          	slli	a2,a2,0x10
aaaaea88:	0055d693          	srli	a3,a1,0x5
aaaaea8c:	01065613          	srli	a2,a2,0x10
aaaaea90:	00c6c6b3          	xor	a3,a3,a2
aaaaea94:	0016f693          	andi	a3,a3,1
aaaaea98:	40d006b3          	neg	a3,a3
aaaaea9c:	00165613          	srli	a2,a2,0x1
aaaaeaa0:	0126f6b3          	and	a3,a3,s2
aaaaeaa4:	00c6c6b3          	xor	a3,a3,a2
aaaaeaa8:	01069693          	slli	a3,a3,0x10
aaaaeaac:	0065d713          	srli	a4,a1,0x6
aaaaeab0:	0106d693          	srli	a3,a3,0x10
aaaaeab4:	00d74733          	xor	a4,a4,a3
aaaaeab8:	00177713          	andi	a4,a4,1
aaaaeabc:	40e00733          	neg	a4,a4
aaaaeac0:	0016d693          	srli	a3,a3,0x1
aaaaeac4:	01277733          	and	a4,a4,s2
aaaaeac8:	00d74733          	xor	a4,a4,a3
aaaaeacc:	01071713          	slli	a4,a4,0x10
aaaaead0:	01075713          	srli	a4,a4,0x10
aaaaead4:	0075d593          	srli	a1,a1,0x7
aaaaead8:	00e5c5b3          	xor	a1,a1,a4
aaaaeadc:	0015f593          	andi	a1,a1,1
aaaaeae0:	40b005b3          	neg	a1,a1
aaaaeae4:	00175713          	srli	a4,a4,0x1
aaaaeae8:	0125f5b3          	and	a1,a1,s2
aaaaeaec:	00e5c5b3          	xor	a1,a1,a4
aaaaeaf0:	00885793          	srli	a5,a6,0x8
aaaaeaf4:	01059593          	slli	a1,a1,0x10
aaaaeaf8:	0ff7f793          	zext.b	a5,a5
aaaaeafc:	0105d593          	srli	a1,a1,0x10
aaaaeb00:	0027de13          	srli	t3,a5,0x2
aaaaeb04:	0047d813          	srli	a6,a5,0x4
aaaaeb08:	0077d613          	srli	a2,a5,0x7
aaaaeb0c:	0067d713          	srli	a4,a5,0x6
aaaaeb10:	0017d313          	srli	t1,a5,0x1
aaaaeb14:	0037d893          	srli	a7,a5,0x3
aaaaeb18:	0057d693          	srli	a3,a5,0x5
aaaaeb1c:	00b7c7b3          	xor	a5,a5,a1
aaaaeb20:	0017f793          	andi	a5,a5,1
aaaaeb24:	40f007b3          	neg	a5,a5
aaaaeb28:	0015d593          	srli	a1,a1,0x1
aaaaeb2c:	0127f7b3          	and	a5,a5,s2
aaaaeb30:	00b7c7b3          	xor	a5,a5,a1
aaaaeb34:	01079793          	slli	a5,a5,0x10
aaaaeb38:	0107d793          	srli	a5,a5,0x10
aaaaeb3c:	00f34333          	xor	t1,t1,a5
aaaaeb40:	00137313          	andi	t1,t1,1
aaaaeb44:	40600333          	neg	t1,t1
aaaaeb48:	0017d793          	srli	a5,a5,0x1
aaaaeb4c:	01237333          	and	t1,t1,s2
aaaaeb50:	00f34333          	xor	t1,t1,a5
aaaaeb54:	01031313          	slli	t1,t1,0x10
aaaaeb58:	01035313          	srli	t1,t1,0x10
aaaaeb5c:	006e47b3          	xor	a5,t3,t1
aaaaeb60:	0017f793          	andi	a5,a5,1
aaaaeb64:	40f007b3          	neg	a5,a5
aaaaeb68:	00135313          	srli	t1,t1,0x1
aaaaeb6c:	0127f7b3          	and	a5,a5,s2
aaaaeb70:	0067c7b3          	xor	a5,a5,t1
aaaaeb74:	01079793          	slli	a5,a5,0x10
aaaaeb78:	0107d793          	srli	a5,a5,0x10
aaaaeb7c:	00f8c8b3          	xor	a7,a7,a5
aaaaeb80:	0018f893          	andi	a7,a7,1
aaaaeb84:	411008b3          	neg	a7,a7
aaaaeb88:	0017d793          	srli	a5,a5,0x1
aaaaeb8c:	0128f8b3          	and	a7,a7,s2
aaaaeb90:	00f8c8b3          	xor	a7,a7,a5
aaaaeb94:	01089893          	slli	a7,a7,0x10
aaaaeb98:	0108d893          	srli	a7,a7,0x10
aaaaeb9c:	011847b3          	xor	a5,a6,a7
aaaaeba0:	0017f793          	andi	a5,a5,1
aaaaeba4:	40f007b3          	neg	a5,a5
aaaaeba8:	0018d893          	srli	a7,a7,0x1
aaaaebac:	0127f7b3          	and	a5,a5,s2
aaaaebb0:	0117c7b3          	xor	a5,a5,a7
aaaaebb4:	01079793          	slli	a5,a5,0x10
aaaaebb8:	0107d793          	srli	a5,a5,0x10
aaaaebbc:	00f6c6b3          	xor	a3,a3,a5
aaaaebc0:	0016f693          	andi	a3,a3,1
aaaaebc4:	40d006b3          	neg	a3,a3
aaaaebc8:	0017d793          	srli	a5,a5,0x1
aaaaebcc:	0126f6b3          	and	a3,a3,s2
aaaaebd0:	00f6c6b3          	xor	a3,a3,a5
aaaaebd4:	01069693          	slli	a3,a3,0x10
aaaaebd8:	0106d693          	srli	a3,a3,0x10
aaaaebdc:	00d747b3          	xor	a5,a4,a3
aaaaebe0:	0017f793          	andi	a5,a5,1
aaaaebe4:	40f007b3          	neg	a5,a5
aaaaebe8:	0016d693          	srli	a3,a3,0x1
aaaaebec:	0127f7b3          	and	a5,a5,s2
aaaaebf0:	00d7c7b3          	xor	a5,a5,a3
aaaaebf4:	01079793          	slli	a5,a5,0x10
aaaaebf8:	0107d793          	srli	a5,a5,0x10
aaaaebfc:	00f64733          	xor	a4,a2,a5
aaaaec00:	00177713          	andi	a4,a4,1
aaaaec04:	40e00733          	neg	a4,a4
aaaaec08:	01277733          	and	a4,a4,s2
aaaaec0c:	0017d793          	srli	a5,a5,0x1
aaaaec10:	00f747b3          	xor	a5,a4,a5
aaaaec14:	fff00593          	li	a1,-1
aaaaec18:	00048513          	mv	a0,s1
aaaaec1c:	04f11223          	sh	a5,68(sp)
aaaaec20:	ffffe097          	auipc	ra,0xffffe
aaaaec24:	768080e7          	jalr	1896(ra) # aaaad388 <core_bench_list>
aaaaec28:	04415783          	lhu	a5,68(sp)
aaaaec2c:	0ff57813          	zext.b	a6,a0
aaaaec30:	00285713          	srli	a4,a6,0x2
aaaaec34:	00f846b3          	xor	a3,a6,a5
aaaaec38:	0016f693          	andi	a3,a3,1
aaaaec3c:	40d006b3          	neg	a3,a3
aaaaec40:	0017d793          	srli	a5,a5,0x1
aaaaec44:	0126f6b3          	and	a3,a3,s2
aaaaec48:	00f6c6b3          	xor	a3,a3,a5
aaaaec4c:	01069693          	slli	a3,a3,0x10
aaaaec50:	0106d693          	srli	a3,a3,0x10
aaaaec54:	00185793          	srli	a5,a6,0x1
aaaaec58:	00d7c7b3          	xor	a5,a5,a3
aaaaec5c:	0017f793          	andi	a5,a5,1
aaaaec60:	40f007b3          	neg	a5,a5
aaaaec64:	0016d693          	srli	a3,a3,0x1
aaaaec68:	0127f7b3          	and	a5,a5,s2
aaaaec6c:	00d7c7b3          	xor	a5,a5,a3
aaaaec70:	01079793          	slli	a5,a5,0x10
aaaaec74:	0107d793          	srli	a5,a5,0x10
aaaaec78:	00f74733          	xor	a4,a4,a5
aaaaec7c:	00177713          	andi	a4,a4,1
aaaaec80:	40e00733          	neg	a4,a4
aaaaec84:	0017d793          	srli	a5,a5,0x1
aaaaec88:	01277733          	and	a4,a4,s2
aaaaec8c:	00f74733          	xor	a4,a4,a5
aaaaec90:	01071713          	slli	a4,a4,0x10
aaaaec94:	00385613          	srli	a2,a6,0x3
aaaaec98:	01075713          	srli	a4,a4,0x10
aaaaec9c:	00e64633          	xor	a2,a2,a4
aaaaeca0:	00167613          	andi	a2,a2,1
aaaaeca4:	40c00633          	neg	a2,a2
aaaaeca8:	00175713          	srli	a4,a4,0x1
aaaaecac:	01267633          	and	a2,a2,s2
aaaaecb0:	00e64633          	xor	a2,a2,a4
aaaaecb4:	01061613          	slli	a2,a2,0x10
aaaaecb8:	00485693          	srli	a3,a6,0x4
aaaaecbc:	01065613          	srli	a2,a2,0x10
aaaaecc0:	00c6c6b3          	xor	a3,a3,a2
aaaaecc4:	0016f693          	andi	a3,a3,1
aaaaecc8:	40d006b3          	neg	a3,a3
aaaaeccc:	00165613          	srli	a2,a2,0x1
aaaaecd0:	0126f6b3          	and	a3,a3,s2
aaaaecd4:	00c6c6b3          	xor	a3,a3,a2
aaaaecd8:	01069693          	slli	a3,a3,0x10
aaaaecdc:	00585593          	srli	a1,a6,0x5
aaaaece0:	0106d693          	srli	a3,a3,0x10
aaaaece4:	00d5c5b3          	xor	a1,a1,a3
aaaaece8:	0015f593          	andi	a1,a1,1
aaaaecec:	40b005b3          	neg	a1,a1
aaaaecf0:	0016d693          	srli	a3,a3,0x1
aaaaecf4:	0125f5b3          	and	a1,a1,s2
aaaaecf8:	00d5c5b3          	xor	a1,a1,a3
aaaaecfc:	01059593          	slli	a1,a1,0x10
aaaaed00:	00685793          	srli	a5,a6,0x6
aaaaed04:	0105d593          	srli	a1,a1,0x10
aaaaed08:	00b7c7b3          	xor	a5,a5,a1
aaaaed0c:	0017f793          	andi	a5,a5,1
aaaaed10:	40f007b3          	neg	a5,a5
aaaaed14:	0015d593          	srli	a1,a1,0x1
aaaaed18:	0127f7b3          	and	a5,a5,s2
aaaaed1c:	00b7c7b3          	xor	a5,a5,a1
aaaaed20:	01079793          	slli	a5,a5,0x10
aaaaed24:	0107d793          	srli	a5,a5,0x10
aaaaed28:	00785813          	srli	a6,a6,0x7
aaaaed2c:	00f84833          	xor	a6,a6,a5
aaaaed30:	00187813          	andi	a6,a6,1
aaaaed34:	41000833          	neg	a6,a6
aaaaed38:	0017d793          	srli	a5,a5,0x1
aaaaed3c:	01287833          	and	a6,a6,s2
aaaaed40:	00f84833          	xor	a6,a6,a5
aaaaed44:	00855713          	srli	a4,a0,0x8
aaaaed48:	01081813          	slli	a6,a6,0x10
aaaaed4c:	0ff77713          	zext.b	a4,a4
aaaaed50:	01085813          	srli	a6,a6,0x10
aaaaed54:	00275693          	srli	a3,a4,0x2
aaaaed58:	00175613          	srli	a2,a4,0x1
aaaaed5c:	00375f93          	srli	t6,a4,0x3
aaaaed60:	00475f13          	srli	t5,a4,0x4
aaaaed64:	00575513          	srli	a0,a4,0x5
aaaaed68:	00675593          	srli	a1,a4,0x6
aaaaed6c:	00775793          	srli	a5,a4,0x7
aaaaed70:	01074733          	xor	a4,a4,a6
aaaaed74:	00177713          	andi	a4,a4,1
aaaaed78:	40e00733          	neg	a4,a4
aaaaed7c:	00185813          	srli	a6,a6,0x1
aaaaed80:	01277733          	and	a4,a4,s2
aaaaed84:	01074733          	xor	a4,a4,a6
aaaaed88:	01071713          	slli	a4,a4,0x10
aaaaed8c:	01075713          	srli	a4,a4,0x10
aaaaed90:	00100993          	li	s3,1
aaaaed94:	00e64633          	xor	a2,a2,a4
aaaaed98:	01367633          	and	a2,a2,s3
aaaaed9c:	40c00633          	neg	a2,a2
aaaaeda0:	00175713          	srli	a4,a4,0x1
aaaaeda4:	01267633          	and	a2,a2,s2
aaaaeda8:	00e64633          	xor	a2,a2,a4
aaaaedac:	01061613          	slli	a2,a2,0x10
aaaaedb0:	01065613          	srli	a2,a2,0x10
aaaaedb4:	00c6c733          	xor	a4,a3,a2
aaaaedb8:	01377733          	and	a4,a4,s3
aaaaedbc:	40e00733          	neg	a4,a4
aaaaedc0:	00165613          	srli	a2,a2,0x1
aaaaedc4:	01277733          	and	a4,a4,s2
aaaaedc8:	00c74733          	xor	a4,a4,a2
aaaaedcc:	01071713          	slli	a4,a4,0x10
aaaaedd0:	01075713          	srli	a4,a4,0x10
aaaaedd4:	00efcfb3          	xor	t6,t6,a4
aaaaedd8:	013fffb3          	and	t6,t6,s3
aaaaeddc:	41f00fb3          	neg	t6,t6
aaaaede0:	00175713          	srli	a4,a4,0x1
aaaaede4:	012fffb3          	and	t6,t6,s2
aaaaede8:	00efcfb3          	xor	t6,t6,a4
aaaaedec:	010f9f93          	slli	t6,t6,0x10
aaaaedf0:	010fdf93          	srli	t6,t6,0x10
aaaaedf4:	01ff4733          	xor	a4,t5,t6
aaaaedf8:	01377733          	and	a4,a4,s3
aaaaedfc:	40e00733          	neg	a4,a4
aaaaee00:	01277733          	and	a4,a4,s2
aaaaee04:	001fdf93          	srli	t6,t6,0x1
aaaaee08:	01f74733          	xor	a4,a4,t6
aaaaee0c:	01071713          	slli	a4,a4,0x10
aaaaee10:	01075713          	srli	a4,a4,0x10
aaaaee14:	00e54533          	xor	a0,a0,a4
aaaaee18:	01357533          	and	a0,a0,s3
aaaaee1c:	40a00533          	neg	a0,a0
aaaaee20:	00175713          	srli	a4,a4,0x1
aaaaee24:	01257533          	and	a0,a0,s2
aaaaee28:	00e54533          	xor	a0,a0,a4
aaaaee2c:	01051513          	slli	a0,a0,0x10
aaaaee30:	01055513          	srli	a0,a0,0x10
aaaaee34:	00a5c733          	xor	a4,a1,a0
aaaaee38:	01377733          	and	a4,a4,s3
aaaaee3c:	40e00733          	neg	a4,a4
aaaaee40:	01277733          	and	a4,a4,s2
aaaaee44:	00155513          	srli	a0,a0,0x1
aaaaee48:	00a74733          	xor	a4,a4,a0
aaaaee4c:	01071713          	slli	a4,a4,0x10
aaaaee50:	01075713          	srli	a4,a4,0x10
aaaaee54:	00e7c7b3          	xor	a5,a5,a4
aaaaee58:	0137f7b3          	and	a5,a5,s3
aaaaee5c:	40f007b3          	neg	a5,a5
aaaaee60:	0127f7b3          	and	a5,a5,s2
aaaaee64:	00175713          	srli	a4,a4,0x1
aaaaee68:	00e7c7b3          	xor	a5,a5,a4
aaaaee6c:	01079793          	slli	a5,a5,0x10
aaaaee70:	01011303          	lh	t1,16(sp)
aaaaee74:	01412e83          	lw	t4,20(sp)
aaaaee78:	02412803          	lw	a6,36(sp)
aaaaee7c:	02812603          	lw	a2,40(sp)
aaaaee80:	02c12683          	lw	a3,44(sp)
aaaaee84:	04812e03          	lw	t3,72(sp)
aaaaee88:	04c11883          	lh	a7,76(sp)
aaaaee8c:	0107d793          	srli	a5,a5,0x10
aaaaee90:	51340463          	beq	s0,s3,aaaaf398 <main+0x1568>
aaaaee94:	00078713          	mv	a4,a5
aaaaee98:	0240006f          	j	aaaaeebc <main+0x108c>
aaaaee9c:	01011303          	lh	t1,16(sp)
aaaaeea0:	01412e83          	lw	t4,20(sp)
aaaaeea4:	02412803          	lw	a6,36(sp)
aaaaeea8:	02812603          	lw	a2,40(sp)
aaaaeeac:	02c12683          	lw	a3,44(sp)
aaaaeeb0:	04615703          	lhu	a4,70(sp)
aaaaeeb4:	04812e03          	lw	t3,72(sp)
aaaaeeb8:	04c11883          	lh	a7,76(sp)
aaaaeebc:	00100593          	li	a1,1
aaaaeec0:	00048513          	mv	a0,s1
aaaaeec4:	00611823          	sh	t1,16(sp)
aaaaeec8:	01d12a23          	sw	t4,20(sp)
aaaaeecc:	03012223          	sw	a6,36(sp)
aaaaeed0:	02c12423          	sw	a2,40(sp)
aaaaeed4:	02d12623          	sw	a3,44(sp)
aaaaeed8:	04f11223          	sh	a5,68(sp)
aaaaeedc:	04e11323          	sh	a4,70(sp)
aaaaeee0:	05c12423          	sw	t3,72(sp)
aaaaeee4:	05111623          	sh	a7,76(sp)
aaaaeee8:	ffffe097          	auipc	ra,0xffffe
aaaaeeec:	4a0080e7          	jalr	1184(ra) # aaaad388 <core_bench_list>
aaaaeef0:	04415783          	lhu	a5,68(sp)
aaaaeef4:	0ff57593          	zext.b	a1,a0
aaaaeef8:	0015d713          	srli	a4,a1,0x1
aaaaeefc:	00f5c6b3          	xor	a3,a1,a5
aaaaef00:	0016f693          	andi	a3,a3,1
aaaaef04:	40d006b3          	neg	a3,a3
aaaaef08:	0017d793          	srli	a5,a5,0x1
aaaaef0c:	0126f6b3          	and	a3,a3,s2
aaaaef10:	00f6c6b3          	xor	a3,a3,a5
aaaaef14:	01069693          	slli	a3,a3,0x10
aaaaef18:	0106d693          	srli	a3,a3,0x10
aaaaef1c:	00d74733          	xor	a4,a4,a3
aaaaef20:	00177713          	andi	a4,a4,1
aaaaef24:	40e00733          	neg	a4,a4
aaaaef28:	0016d693          	srli	a3,a3,0x1
aaaaef2c:	01277733          	and	a4,a4,s2
aaaaef30:	00d74733          	xor	a4,a4,a3
aaaaef34:	01071713          	slli	a4,a4,0x10
aaaaef38:	0025d793          	srli	a5,a1,0x2
aaaaef3c:	01075713          	srli	a4,a4,0x10
aaaaef40:	00e7c7b3          	xor	a5,a5,a4
aaaaef44:	0017f793          	andi	a5,a5,1
aaaaef48:	40f007b3          	neg	a5,a5
aaaaef4c:	00175713          	srli	a4,a4,0x1
aaaaef50:	0127f7b3          	and	a5,a5,s2
aaaaef54:	00e7c7b3          	xor	a5,a5,a4
aaaaef58:	01079793          	slli	a5,a5,0x10
aaaaef5c:	00050813          	mv	a6,a0
aaaaef60:	0107d793          	srli	a5,a5,0x10
aaaaef64:	0035d513          	srli	a0,a1,0x3
aaaaef68:	00f54533          	xor	a0,a0,a5
aaaaef6c:	00157513          	andi	a0,a0,1
aaaaef70:	40a00533          	neg	a0,a0
aaaaef74:	0017d793          	srli	a5,a5,0x1
aaaaef78:	01257533          	and	a0,a0,s2
aaaaef7c:	00f54533          	xor	a0,a0,a5
aaaaef80:	01051513          	slli	a0,a0,0x10
aaaaef84:	0045d613          	srli	a2,a1,0x4
aaaaef88:	01055513          	srli	a0,a0,0x10
aaaaef8c:	00a64633          	xor	a2,a2,a0
aaaaef90:	00167613          	andi	a2,a2,1
aaaaef94:	40c00633          	neg	a2,a2
aaaaef98:	00155513          	srli	a0,a0,0x1
aaaaef9c:	01267633          	and	a2,a2,s2
aaaaefa0:	00a64633          	xor	a2,a2,a0
aaaaefa4:	01061613          	slli	a2,a2,0x10
aaaaefa8:	0055d693          	srli	a3,a1,0x5
aaaaefac:	01065613          	srli	a2,a2,0x10
aaaaefb0:	00c6c6b3          	xor	a3,a3,a2
aaaaefb4:	0016f693          	andi	a3,a3,1
aaaaefb8:	40d006b3          	neg	a3,a3
aaaaefbc:	00165613          	srli	a2,a2,0x1
aaaaefc0:	0126f6b3          	and	a3,a3,s2
aaaaefc4:	00c6c6b3          	xor	a3,a3,a2
aaaaefc8:	01069693          	slli	a3,a3,0x10
aaaaefcc:	0065d713          	srli	a4,a1,0x6
aaaaefd0:	0106d693          	srli	a3,a3,0x10
aaaaefd4:	00d74733          	xor	a4,a4,a3
aaaaefd8:	00177713          	andi	a4,a4,1
aaaaefdc:	40e00733          	neg	a4,a4
aaaaefe0:	0016d693          	srli	a3,a3,0x1
aaaaefe4:	01277733          	and	a4,a4,s2
aaaaefe8:	00d74733          	xor	a4,a4,a3
aaaaefec:	01071713          	slli	a4,a4,0x10
aaaaeff0:	01075713          	srli	a4,a4,0x10
aaaaeff4:	0075d593          	srli	a1,a1,0x7
aaaaeff8:	00e5c5b3          	xor	a1,a1,a4
aaaaeffc:	0015f593          	andi	a1,a1,1
aaaaf000:	40b005b3          	neg	a1,a1
aaaaf004:	00175713          	srli	a4,a4,0x1
aaaaf008:	0125f5b3          	and	a1,a1,s2
aaaaf00c:	00e5c5b3          	xor	a1,a1,a4
aaaaf010:	00885793          	srli	a5,a6,0x8
aaaaf014:	01059593          	slli	a1,a1,0x10
aaaaf018:	0ff7f793          	zext.b	a5,a5
aaaaf01c:	0105d593          	srli	a1,a1,0x10
aaaaf020:	0047d813          	srli	a6,a5,0x4
aaaaf024:	0077d613          	srli	a2,a5,0x7
aaaaf028:	0027de13          	srli	t3,a5,0x2
aaaaf02c:	0067d713          	srli	a4,a5,0x6
aaaaf030:	0017d313          	srli	t1,a5,0x1
aaaaf034:	0037d893          	srli	a7,a5,0x3
aaaaf038:	0057d693          	srli	a3,a5,0x5
aaaaf03c:	00b7c7b3          	xor	a5,a5,a1
aaaaf040:	0017f793          	andi	a5,a5,1
aaaaf044:	40f007b3          	neg	a5,a5
aaaaf048:	0015d593          	srli	a1,a1,0x1
aaaaf04c:	0127f7b3          	and	a5,a5,s2
aaaaf050:	00b7c7b3          	xor	a5,a5,a1
aaaaf054:	01079793          	slli	a5,a5,0x10
aaaaf058:	0107d793          	srli	a5,a5,0x10
aaaaf05c:	00f34333          	xor	t1,t1,a5
aaaaf060:	00137313          	andi	t1,t1,1
aaaaf064:	40600333          	neg	t1,t1
aaaaf068:	0017d793          	srli	a5,a5,0x1
aaaaf06c:	01237333          	and	t1,t1,s2
aaaaf070:	00f34333          	xor	t1,t1,a5
aaaaf074:	01031313          	slli	t1,t1,0x10
aaaaf078:	01035313          	srli	t1,t1,0x10
aaaaf07c:	006e47b3          	xor	a5,t3,t1
aaaaf080:	0017f793          	andi	a5,a5,1
aaaaf084:	40f007b3          	neg	a5,a5
aaaaf088:	00135313          	srli	t1,t1,0x1
aaaaf08c:	0127f7b3          	and	a5,a5,s2
aaaaf090:	0067c7b3          	xor	a5,a5,t1
aaaaf094:	01079793          	slli	a5,a5,0x10
aaaaf098:	0107d793          	srli	a5,a5,0x10
aaaaf09c:	00f8c8b3          	xor	a7,a7,a5
aaaaf0a0:	0018f893          	andi	a7,a7,1
aaaaf0a4:	411008b3          	neg	a7,a7
aaaaf0a8:	0017d793          	srli	a5,a5,0x1
aaaaf0ac:	0128f8b3          	and	a7,a7,s2
aaaaf0b0:	00f8c8b3          	xor	a7,a7,a5
aaaaf0b4:	01089893          	slli	a7,a7,0x10
aaaaf0b8:	0108d893          	srli	a7,a7,0x10
aaaaf0bc:	011847b3          	xor	a5,a6,a7
aaaaf0c0:	0017f793          	andi	a5,a5,1
aaaaf0c4:	40f007b3          	neg	a5,a5
aaaaf0c8:	0018d893          	srli	a7,a7,0x1
aaaaf0cc:	0127f7b3          	and	a5,a5,s2
aaaaf0d0:	0117c7b3          	xor	a5,a5,a7
aaaaf0d4:	01079793          	slli	a5,a5,0x10
aaaaf0d8:	0107d793          	srli	a5,a5,0x10
aaaaf0dc:	00f6c6b3          	xor	a3,a3,a5
aaaaf0e0:	0016f693          	andi	a3,a3,1
aaaaf0e4:	40d006b3          	neg	a3,a3
aaaaf0e8:	0017d793          	srli	a5,a5,0x1
aaaaf0ec:	0126f6b3          	and	a3,a3,s2
aaaaf0f0:	00f6c6b3          	xor	a3,a3,a5
aaaaf0f4:	01069693          	slli	a3,a3,0x10
aaaaf0f8:	0106d693          	srli	a3,a3,0x10
aaaaf0fc:	00d747b3          	xor	a5,a4,a3
aaaaf100:	0017f793          	andi	a5,a5,1
aaaaf104:	40f007b3          	neg	a5,a5
aaaaf108:	0016d693          	srli	a3,a3,0x1
aaaaf10c:	0127f7b3          	and	a5,a5,s2
aaaaf110:	00d7c7b3          	xor	a5,a5,a3
aaaaf114:	01079793          	slli	a5,a5,0x10
aaaaf118:	0107d793          	srli	a5,a5,0x10
aaaaf11c:	00f64733          	xor	a4,a2,a5
aaaaf120:	00177713          	andi	a4,a4,1
aaaaf124:	40e00733          	neg	a4,a4
aaaaf128:	01277733          	and	a4,a4,s2
aaaaf12c:	0017d793          	srli	a5,a5,0x1
aaaaf130:	00f747b3          	xor	a5,a4,a5
aaaaf134:	fff00593          	li	a1,-1
aaaaf138:	00048513          	mv	a0,s1
aaaaf13c:	04f11223          	sh	a5,68(sp)
aaaaf140:	ffffe097          	auipc	ra,0xffffe
aaaaf144:	248080e7          	jalr	584(ra) # aaaad388 <core_bench_list>
aaaaf148:	04415783          	lhu	a5,68(sp)
aaaaf14c:	0ff57893          	zext.b	a7,a0
aaaaf150:	0028d713          	srli	a4,a7,0x2
aaaaf154:	00f8c6b3          	xor	a3,a7,a5
aaaaf158:	0016f693          	andi	a3,a3,1
aaaaf15c:	40d006b3          	neg	a3,a3
aaaaf160:	0017d793          	srli	a5,a5,0x1
aaaaf164:	0126f6b3          	and	a3,a3,s2
aaaaf168:	00f6c6b3          	xor	a3,a3,a5
aaaaf16c:	01069693          	slli	a3,a3,0x10
aaaaf170:	0106d693          	srli	a3,a3,0x10
aaaaf174:	0018d793          	srli	a5,a7,0x1
aaaaf178:	00d7c7b3          	xor	a5,a5,a3
aaaaf17c:	0017f793          	andi	a5,a5,1
aaaaf180:	40f007b3          	neg	a5,a5
aaaaf184:	0016d693          	srli	a3,a3,0x1
aaaaf188:	0127f7b3          	and	a5,a5,s2
aaaaf18c:	00d7c7b3          	xor	a5,a5,a3
aaaaf190:	01079793          	slli	a5,a5,0x10
aaaaf194:	0107d793          	srli	a5,a5,0x10
aaaaf198:	00f74733          	xor	a4,a4,a5
aaaaf19c:	00177713          	andi	a4,a4,1
aaaaf1a0:	40e00733          	neg	a4,a4
aaaaf1a4:	0017d793          	srli	a5,a5,0x1
aaaaf1a8:	01277733          	and	a4,a4,s2
aaaaf1ac:	00f74733          	xor	a4,a4,a5
aaaaf1b0:	01071713          	slli	a4,a4,0x10
aaaaf1b4:	0038d593          	srli	a1,a7,0x3
aaaaf1b8:	01075713          	srli	a4,a4,0x10
aaaaf1bc:	00e5c5b3          	xor	a1,a1,a4
aaaaf1c0:	0015f593          	andi	a1,a1,1
aaaaf1c4:	40b005b3          	neg	a1,a1
aaaaf1c8:	00175713          	srli	a4,a4,0x1
aaaaf1cc:	0125f5b3          	and	a1,a1,s2
aaaaf1d0:	00e5c5b3          	xor	a1,a1,a4
aaaaf1d4:	01059593          	slli	a1,a1,0x10
aaaaf1d8:	0048d613          	srli	a2,a7,0x4
aaaaf1dc:	0105d593          	srli	a1,a1,0x10
aaaaf1e0:	00b64633          	xor	a2,a2,a1
aaaaf1e4:	00167613          	andi	a2,a2,1
aaaaf1e8:	40c00633          	neg	a2,a2
aaaaf1ec:	0015d593          	srli	a1,a1,0x1
aaaaf1f0:	01267633          	and	a2,a2,s2
aaaaf1f4:	00b64633          	xor	a2,a2,a1
aaaaf1f8:	01061613          	slli	a2,a2,0x10
aaaaf1fc:	0058d693          	srli	a3,a7,0x5
aaaaf200:	01065613          	srli	a2,a2,0x10
aaaaf204:	00c6c6b3          	xor	a3,a3,a2
aaaaf208:	0016f693          	andi	a3,a3,1
aaaaf20c:	40d006b3          	neg	a3,a3
aaaaf210:	00165613          	srli	a2,a2,0x1
aaaaf214:	0126f6b3          	and	a3,a3,s2
aaaaf218:	00c6c6b3          	xor	a3,a3,a2
aaaaf21c:	01069693          	slli	a3,a3,0x10
aaaaf220:	0068d793          	srli	a5,a7,0x6
aaaaf224:	0106d693          	srli	a3,a3,0x10
aaaaf228:	00d7c7b3          	xor	a5,a5,a3
aaaaf22c:	0017f793          	andi	a5,a5,1
aaaaf230:	40f007b3          	neg	a5,a5
aaaaf234:	0016d693          	srli	a3,a3,0x1
aaaaf238:	0127f7b3          	and	a5,a5,s2
aaaaf23c:	00d7c7b3          	xor	a5,a5,a3
aaaaf240:	01079793          	slli	a5,a5,0x10
aaaaf244:	0107d793          	srli	a5,a5,0x10
aaaaf248:	0078d893          	srli	a7,a7,0x7
aaaaf24c:	00f8c8b3          	xor	a7,a7,a5
aaaaf250:	0018f893          	andi	a7,a7,1
aaaaf254:	411008b3          	neg	a7,a7
aaaaf258:	0017d793          	srli	a5,a5,0x1
aaaaf25c:	0128f8b3          	and	a7,a7,s2
aaaaf260:	00f8c8b3          	xor	a7,a7,a5
aaaaf264:	00855713          	srli	a4,a0,0x8
aaaaf268:	01089893          	slli	a7,a7,0x10
aaaaf26c:	0ff77713          	zext.b	a4,a4
aaaaf270:	0108d893          	srli	a7,a7,0x10
aaaaf274:	00175813          	srli	a6,a4,0x1
aaaaf278:	00275313          	srli	t1,a4,0x2
aaaaf27c:	00375513          	srli	a0,a4,0x3
aaaaf280:	00475593          	srli	a1,a4,0x4
aaaaf284:	00575613          	srli	a2,a4,0x5
aaaaf288:	00675693          	srli	a3,a4,0x6
aaaaf28c:	00775793          	srli	a5,a4,0x7
aaaaf290:	01174733          	xor	a4,a4,a7
aaaaf294:	00177713          	andi	a4,a4,1
aaaaf298:	40e00733          	neg	a4,a4
aaaaf29c:	01277733          	and	a4,a4,s2
aaaaf2a0:	0018d893          	srli	a7,a7,0x1
aaaaf2a4:	01174733          	xor	a4,a4,a7
aaaaf2a8:	01071713          	slli	a4,a4,0x10
aaaaf2ac:	01075713          	srli	a4,a4,0x10
aaaaf2b0:	00e84833          	xor	a6,a6,a4
aaaaf2b4:	00187813          	andi	a6,a6,1
aaaaf2b8:	41000833          	neg	a6,a6
aaaaf2bc:	00175713          	srli	a4,a4,0x1
aaaaf2c0:	01287833          	and	a6,a6,s2
aaaaf2c4:	00e84833          	xor	a6,a6,a4
aaaaf2c8:	01081813          	slli	a6,a6,0x10
aaaaf2cc:	01085813          	srli	a6,a6,0x10
aaaaf2d0:	01034733          	xor	a4,t1,a6
aaaaf2d4:	00177713          	andi	a4,a4,1
aaaaf2d8:	40e00733          	neg	a4,a4
aaaaf2dc:	01277733          	and	a4,a4,s2
aaaaf2e0:	00185813          	srli	a6,a6,0x1
aaaaf2e4:	01074733          	xor	a4,a4,a6
aaaaf2e8:	01071713          	slli	a4,a4,0x10
aaaaf2ec:	01075713          	srli	a4,a4,0x10
aaaaf2f0:	00e54533          	xor	a0,a0,a4
aaaaf2f4:	00157513          	andi	a0,a0,1
aaaaf2f8:	40a00533          	neg	a0,a0
aaaaf2fc:	00175713          	srli	a4,a4,0x1
aaaaf300:	01257533          	and	a0,a0,s2
aaaaf304:	00e54533          	xor	a0,a0,a4
aaaaf308:	01051513          	slli	a0,a0,0x10
aaaaf30c:	01055513          	srli	a0,a0,0x10
aaaaf310:	00a5c733          	xor	a4,a1,a0
aaaaf314:	00177713          	andi	a4,a4,1
aaaaf318:	40e00733          	neg	a4,a4
aaaaf31c:	01277733          	and	a4,a4,s2
aaaaf320:	00155513          	srli	a0,a0,0x1
aaaaf324:	00a74733          	xor	a4,a4,a0
aaaaf328:	01071713          	slli	a4,a4,0x10
aaaaf32c:	01075713          	srli	a4,a4,0x10
aaaaf330:	00e64633          	xor	a2,a2,a4
aaaaf334:	00167613          	andi	a2,a2,1
aaaaf338:	40c00633          	neg	a2,a2
aaaaf33c:	00175713          	srli	a4,a4,0x1
aaaaf340:	01267633          	and	a2,a2,s2
aaaaf344:	00e64633          	xor	a2,a2,a4
aaaaf348:	01061613          	slli	a2,a2,0x10
aaaaf34c:	01065613          	srli	a2,a2,0x10
aaaaf350:	00c6c733          	xor	a4,a3,a2
aaaaf354:	00177713          	andi	a4,a4,1
aaaaf358:	40e00733          	neg	a4,a4
aaaaf35c:	01277733          	and	a4,a4,s2
aaaaf360:	00165613          	srli	a2,a2,0x1
aaaaf364:	00c74733          	xor	a4,a4,a2
aaaaf368:	01071713          	slli	a4,a4,0x10
aaaaf36c:	01075713          	srli	a4,a4,0x10
aaaaf370:	00e7c7b3          	xor	a5,a5,a4
aaaaf374:	0017f793          	andi	a5,a5,1
aaaaf378:	40f007b3          	neg	a5,a5
aaaaf37c:	0127f7b3          	and	a5,a5,s2
aaaaf380:	00175713          	srli	a4,a4,0x1
aaaaf384:	00e7c7b3          	xor	a5,a5,a4
aaaaf388:	01079793          	slli	a5,a5,0x10
aaaaf38c:	00198993          	addi	s3,s3,1
aaaaf390:	0107d793          	srli	a5,a5,0x10
aaaaf394:	b13414e3          	bne	s0,s3,aaaaee9c <main+0x106c>
aaaaf398:	00402013          	slti	zero,zero,4
aaaaf39c:	00202013          	slti	zero,zero,2
aaaaf3a0:	07c12083          	lw	ra,124(sp)
aaaaf3a4:	07812403          	lw	s0,120(sp)
aaaaf3a8:	07412483          	lw	s1,116(sp)
aaaaf3ac:	07012903          	lw	s2,112(sp)
aaaaf3b0:	06c12983          	lw	s3,108(sp)
aaaaf3b4:	06812a03          	lw	s4,104(sp)
aaaaf3b8:	06412a83          	lw	s5,100(sp)
aaaaf3bc:	06012b03          	lw	s6,96(sp)
aaaaf3c0:	05c12b83          	lw	s7,92(sp)
aaaaf3c4:	05812c03          	lw	s8,88(sp)
aaaaf3c8:	05412c83          	lw	s9,84(sp)
aaaaf3cc:	00000513          	li	a0,0
aaaaf3d0:	08010113          	addi	sp,sp,128
aaaaf3d4:	00008067          	ret
aaaaf3d8:	00000793          	li	a5,0
aaaaf3dc:	00f12623          	sw	a5,12(sp)
aaaaf3e0:	06600813          	li	a6,102
aaaaf3e4:	b21fe06f          	j	aaaadf04 <main+0xd4>
aaaaf3e8:	00c11e83          	lh	t4,12(sp)
aaaaf3ec:	02012f83          	lw	t6,32(sp)
aaaaf3f0:	00002f17          	auipc	t5,0x2
aaaaf3f4:	c10f0f13          	addi	t5,t5,-1008 # aaab1000 <static_memblk>
aaaaf3f8:	01e12c23          	sw	t5,24(sp)
aaaaf3fc:	7d000893          	li	a7,2000
aaaaf400:	7cf00293          	li	t0,1999
aaaaf404:	ccccd537          	lui	a0,0xccccd
aaaaf408:	ccd50513          	addi	a0,a0,-819 # cccccccd <__global_pointer$+0x2221accd>
aaaaf40c:	02a8b533          	mulhu	a0,a7,a0
aaaaf410:	01812703          	lw	a4,24(sp)
aaaaf414:	ffff87b7          	lui	a5,0xffff8
aaaaf418:	08078793          	addi	a5,a5,128 # ffff8080 <_stack_top+0xfff8080>
aaaaf41c:	00072023          	sw	zero,0(a4)
aaaaf420:	01070693          	addi	a3,a4,16
aaaaf424:	00870613          	addi	a2,a4,8
aaaaf428:	ffff8e37          	lui	t3,0xffff8
aaaaf42c:	00455513          	srli	a0,a0,0x4
aaaaf430:	ffe50513          	addi	a0,a0,-2
aaaaf434:	00351913          	slli	s2,a0,0x3
aaaaf438:	01270933          	add	s2,a4,s2
aaaaf43c:	01272223          	sw	s2,4(a4)
aaaaf440:	00f91023          	sh	a5,0(s2)
aaaaf444:	00251a93          	slli	s5,a0,0x2
aaaaf448:	00091123          	sh	zero,2(s2)
aaaaf44c:	01590ab3          	add	s5,s2,s5
aaaaf450:	00490793          	addi	a5,s2,4
aaaaf454:	6926f063          	bgeu	a3,s2,aaaafad4 <main+0x1ca4>
aaaaf458:	00890593          	addi	a1,s2,8
aaaaf45c:	6755fc63          	bgeu	a1,s5,aaaafad4 <main+0x1ca4>
aaaaf460:	00f72623          	sw	a5,12(a4)
aaaaf464:	00072423          	sw	zero,8(a4)
aaaaf468:	00c72023          	sw	a2,0(a4)
aaaaf46c:	fffe4793          	not	a5,t3
aaaaf470:	fff00e13          	li	t3,-1
aaaaf474:	00f91323          	sh	a5,6(s2)
aaaaf478:	01c91223          	sh	t3,4(s2)
aaaaf47c:	010e9b93          	slli	s7,t4,0x10
aaaaf480:	ffff8b37          	lui	s6,0xffff8
aaaaf484:	00868493          	addi	s1,a3,8
aaaaf488:	010bdb93          	srli	s7,s7,0x10
aaaaf48c:	fffb4b13          	not	s6,s6
aaaaf490:	00000e13          	li	t3,0
aaaaf494:	0724f063          	bgeu	s1,s2,aaaaf4f4 <main+0x16c4>
aaaaf498:	00458993          	addi	s3,a1,4
aaaaf49c:	6f59f663          	bgeu	s3,s5,aaaafb88 <main+0x1d58>
aaaaf4a0:	010e1c13          	slli	s8,t3,0x10
aaaaf4a4:	010c5c13          	srli	s8,s8,0x10
aaaaf4a8:	017c47b3          	xor	a5,s8,s7
aaaaf4ac:	00379793          	slli	a5,a5,0x3
aaaaf4b0:	0787f793          	andi	a5,a5,120
aaaaf4b4:	007c7c13          	andi	s8,s8,7
aaaaf4b8:	00c6a023          	sw	a2,0(a3)
aaaaf4bc:	0187e7b3          	or	a5,a5,s8
aaaaf4c0:	00d72023          	sw	a3,0(a4)
aaaaf4c4:	00879613          	slli	a2,a5,0x8
aaaaf4c8:	00b6a223          	sw	a1,4(a3)
aaaaf4cc:	00c787b3          	add	a5,a5,a2
aaaaf4d0:	01659123          	sh	s6,2(a1)
aaaaf4d4:	001e0e13          	addi	t3,t3,1 # ffff8001 <_stack_top+0xfff8001>
aaaaf4d8:	00f59023          	sh	a5,0(a1)
aaaaf4dc:	5cae0a63          	beq	t3,a0,aaaafab0 <main+0x1c80>
aaaaf4e0:	00068613          	mv	a2,a3
aaaaf4e4:	00048693          	mv	a3,s1
aaaaf4e8:	00868493          	addi	s1,a3,8
aaaaf4ec:	00098593          	mv	a1,s3
aaaaf4f0:	fb24e4e3          	bltu	s1,s2,aaaaf498 <main+0x1668>
aaaaf4f4:	00062e03          	lw	t3,0(a2)
aaaaf4f8:	080e0063          	beqz	t3,aaaaf578 <main+0x1748>
aaaaf4fc:	ccccd7b7          	lui	a5,0xccccd
aaaaf500:	ccd78793          	addi	a5,a5,-819 # cccccccd <__global_pointer$+0x2221accd>
aaaaf504:	02f53533          	mulhu	a0,a0,a5
aaaaf508:	00004937          	lui	s2,0x4
aaaaf50c:	fff90913          	addi	s2,s2,-1 # 3fff <_start-0xaaaa6001>
aaaaf510:	20000793          	li	a5,512
aaaaf514:	00100693          	li	a3,1
aaaaf518:	00255513          	srli	a0,a0,0x2
aaaaf51c:	0280006f          	j	aaaaf544 <main+0x1714>
aaaaf520:	000e2583          	lw	a1,0(t3)
aaaaf524:	10078793          	addi	a5,a5,256
aaaaf528:	00d49123          	sh	a3,2(s1)
aaaaf52c:	01079793          	slli	a5,a5,0x10
aaaaf530:	0107d793          	srli	a5,a5,0x10
aaaaf534:	00168693          	addi	a3,a3,1
aaaaf538:	04058063          	beqz	a1,aaaaf578 <main+0x1748>
aaaaf53c:	000e0613          	mv	a2,t3
aaaaf540:	00058e13          	mv	t3,a1
aaaaf544:	00462483          	lw	s1,4(a2)
aaaaf548:	fca6ece3          	bltu	a3,a0,aaaaf520 <main+0x16f0>
aaaaf54c:	00dec5b3          	xor	a1,t4,a3
aaaaf550:	7007f613          	andi	a2,a5,1792
aaaaf554:	00b66633          	or	a2,a2,a1
aaaaf558:	000e2583          	lw	a1,0(t3)
aaaaf55c:	01267633          	and	a2,a2,s2
aaaaf560:	10078793          	addi	a5,a5,256
aaaaf564:	01079793          	slli	a5,a5,0x10
aaaaf568:	00c49123          	sh	a2,2(s1)
aaaaf56c:	0107d793          	srli	a5,a5,0x10
aaaaf570:	00168693          	addi	a3,a3,1
aaaaf574:	fc0594e3          	bnez	a1,aaaaf53c <main+0x170c>
aaaaf578:	00100493          	li	s1,1
aaaaf57c:	00048993          	mv	s3,s1
aaaaf580:	00000e13          	li	t3,0
aaaaf584:	00000613          	li	a2,0
aaaaf588:	00000913          	li	s2,0
aaaaf58c:	00190913          	addi	s2,s2,1
aaaaf590:	00070793          	mv	a5,a4
aaaaf594:	00000693          	li	a3,0
aaaaf598:	0096d863          	bge	a3,s1,aaaaf5a8 <main+0x1778>
aaaaf59c:	0007a783          	lw	a5,0(a5)
aaaaf5a0:	00168693          	addi	a3,a3,1
aaaaf5a4:	fe079ae3          	bnez	a5,aaaaf598 <main+0x1768>
aaaaf5a8:	00048593          	mv	a1,s1
aaaaf5ac:	06d05a63          	blez	a3,aaaaf620 <main+0x17f0>
aaaaf5b0:	0a058e63          	beqz	a1,aaaaf66c <main+0x183c>
aaaaf5b4:	10078463          	beqz	a5,aaaaf6bc <main+0x188c>
aaaaf5b8:	00472c03          	lw	s8,4(a4)
aaaaf5bc:	0047aa83          	lw	s5,4(a5)
aaaaf5c0:	000c1503          	lh	a0,0(s8)
aaaaf5c4:	002a9b03          	lh	s6,2(s5)
aaaaf5c8:	002c1b83          	lh	s7,2(s8)
aaaaf5cc:	01051c93          	slli	s9,a0,0x10
aaaaf5d0:	010cdc93          	srli	s9,s9,0x10
aaaaf5d4:	f0057513          	andi	a0,a0,-256
aaaaf5d8:	008cdc93          	srli	s9,s9,0x8
aaaaf5dc:	01956533          	or	a0,a0,s9
aaaaf5e0:	00ac1023          	sh	a0,0(s8)
aaaaf5e4:	000a9503          	lh	a0,0(s5)
aaaaf5e8:	01051c13          	slli	s8,a0,0x10
aaaaf5ec:	010c5c13          	srli	s8,s8,0x10
aaaaf5f0:	f0057513          	andi	a0,a0,-256
aaaaf5f4:	008c5c13          	srli	s8,s8,0x8
aaaaf5f8:	01856533          	or	a0,a0,s8
aaaaf5fc:	00aa9023          	sh	a0,0(s5)
aaaaf600:	0b7b5e63          	bge	s6,s7,aaaaf6bc <main+0x188c>
aaaaf604:	00078513          	mv	a0,a5
aaaaf608:	0007a783          	lw	a5,0(a5)
aaaaf60c:	fff58593          	addi	a1,a1,-1
aaaaf610:	0a060063          	beqz	a2,aaaaf6b0 <main+0x1880>
aaaaf614:	00a62023          	sw	a0,0(a2)
aaaaf618:	00050613          	mv	a2,a0
aaaaf61c:	f8d04ae3          	bgtz	a3,aaaaf5b0 <main+0x1780>
aaaaf620:	48b05463          	blez	a1,aaaafaa8 <main+0x1c78>
aaaaf624:	0a078463          	beqz	a5,aaaaf6cc <main+0x189c>
aaaaf628:	f80698e3          	bnez	a3,aaaaf5b8 <main+0x1788>
aaaaf62c:	0007a683          	lw	a3,0(a5)
aaaaf630:	fff58593          	addi	a1,a1,-1
aaaaf634:	02060263          	beqz	a2,aaaaf658 <main+0x1828>
aaaaf638:	00f62023          	sw	a5,0(a2)
aaaaf63c:	02058263          	beqz	a1,aaaaf660 <main+0x1830>
aaaaf640:	00078613          	mv	a2,a5
aaaaf644:	08068463          	beqz	a3,aaaaf6cc <main+0x189c>
aaaaf648:	00068793          	mv	a5,a3
aaaaf64c:	0007a683          	lw	a3,0(a5)
aaaaf650:	fff58593          	addi	a1,a1,-1
aaaaf654:	fe0612e3          	bnez	a2,aaaaf638 <main+0x1808>
aaaaf658:	00078e13          	mv	t3,a5
aaaaf65c:	fe0592e3          	bnez	a1,aaaaf640 <main+0x1810>
aaaaf660:	00078713          	mv	a4,a5
aaaaf664:	00068793          	mv	a5,a3
aaaaf668:	0340006f          	j	aaaaf69c <main+0x186c>
aaaaf66c:	00072583          	lw	a1,0(a4)
aaaaf670:	fff68693          	addi	a3,a3,-1
aaaaf674:	02060063          	beqz	a2,aaaaf694 <main+0x1864>
aaaaf678:	00e62023          	sw	a4,0(a2)
aaaaf67c:	02068063          	beqz	a3,aaaaf69c <main+0x186c>
aaaaf680:	00070613          	mv	a2,a4
aaaaf684:	00058713          	mv	a4,a1
aaaaf688:	00072583          	lw	a1,0(a4)
aaaaf68c:	fff68693          	addi	a3,a3,-1
aaaaf690:	fe0614e3          	bnez	a2,aaaaf678 <main+0x1848>
aaaaf694:	00070e13          	mv	t3,a4
aaaaf698:	fe0694e3          	bnez	a3,aaaaf680 <main+0x1850>
aaaaf69c:	00070613          	mv	a2,a4
aaaaf6a0:	02078663          	beqz	a5,aaaaf6cc <main+0x189c>
aaaaf6a4:	00070613          	mv	a2,a4
aaaaf6a8:	00078713          	mv	a4,a5
aaaaf6ac:	ee1ff06f          	j	aaaaf58c <main+0x175c>
aaaaf6b0:	00050e13          	mv	t3,a0
aaaaf6b4:	00050613          	mv	a2,a0
aaaaf6b8:	f65ff06f          	j	aaaaf61c <main+0x17ec>
aaaaf6bc:	00070513          	mv	a0,a4
aaaaf6c0:	fff68693          	addi	a3,a3,-1
aaaaf6c4:	00072703          	lw	a4,0(a4)
aaaaf6c8:	f49ff06f          	j	aaaaf610 <main+0x17e0>
aaaaf6cc:	00062023          	sw	zero,0(a2)
aaaaf6d0:	03390463          	beq	s2,s3,aaaaf6f8 <main+0x18c8>
aaaaf6d4:	00149493          	slli	s1,s1,0x1
aaaaf6d8:	000e0c63          	beqz	t3,aaaaf6f0 <main+0x18c0>
aaaaf6dc:	000e0793          	mv	a5,t3
aaaaf6e0:	00000713          	li	a4,0
aaaaf6e4:	00000e13          	li	t3,0
aaaaf6e8:	00000913          	li	s2,0
aaaaf6ec:	fb9ff06f          	j	aaaaf6a4 <main+0x1874>
aaaaf6f0:	00002023          	sw	zero,0(zero) # 0 <_start-0xaaaaa000>
aaaaf6f4:	00100073          	ebreak
aaaaf6f8:	03c12823          	sw	t3,48(sp)
aaaaf6fc:	100a1c63          	bnez	s4,aaaaf814 <main+0x19e4>
aaaaf700:	00039463          	bnez	t2,aaaaf708 <main+0x18d8>
aaaaf704:	835fe06f          	j	aaaadf38 <main+0x108>
aaaaf708:	001e8713          	addi	a4,t4,1
aaaaf70c:	01071713          	slli	a4,a4,0x10
aaaaf710:	01075713          	srli	a4,a4,0x10
aaaaf714:	00375793          	srli	a5,a4,0x3
aaaaf718:	00700613          	li	a2,7
aaaaf71c:	00777393          	andi	t2,a4,7
aaaaf720:	00000693          	li	a3,0
aaaaf724:	00001597          	auipc	a1,0x1
aaaaf728:	98c58593          	addi	a1,a1,-1652 # aaab00b0 <floatpat>
aaaaf72c:	00400513          	li	a0,4
aaaaf730:	00100e13          	li	t3,1
aaaaf734:	02c00e93          	li	t4,44
aaaaf738:	0037f793          	andi	a5,a5,3
aaaaf73c:	08c38663          	beq	t2,a2,aaaaf7c8 <main+0x1998>
aaaaf740:	34756c63          	bltu	a0,t2,aaaafa98 <main+0x1c68>
aaaaf744:	ffd38393          	addi	t2,t2,-3
aaaaf748:	01039393          	slli	t2,t2,0x10
aaaaf74c:	0103d393          	srli	t2,t2,0x10
aaaaf750:	1a7e6a63          	bltu	t3,t2,aaaaf904 <main+0x1ad4>
aaaaf754:	00279793          	slli	a5,a5,0x2
aaaaf758:	00f587b3          	add	a5,a1,a5
aaaaf75c:	0007a483          	lw	s1,0(a5)
aaaaf760:	00170713          	addi	a4,a4,1
aaaaf764:	01071713          	slli	a4,a4,0x10
aaaaf768:	00968913          	addi	s2,a3,9
aaaaf76c:	01075713          	srli	a4,a4,0x10
aaaaf770:	18597e63          	bgeu	s2,t0,aaaaf90c <main+0x1adc>
aaaaf774:	00df83b3          	add	t2,t6,a3
aaaaf778:	00148793          	addi	a5,s1,1
aaaaf77c:	40f387b3          	sub	a5,t2,a5
aaaaf780:	0037b793          	sltiu	a5,a5,3
aaaaf784:	32079a63          	bnez	a5,aaaafab8 <main+0x1c88>
aaaaf788:	0074e7b3          	or	a5,s1,t2
aaaaf78c:	0037f793          	andi	a5,a5,3
aaaaf790:	32079463          	bnez	a5,aaaafab8 <main+0x1c88>
aaaaf794:	0004a983          	lw	s3,0(s1)
aaaaf798:	00800793          	li	a5,8
aaaaf79c:	0133a023          	sw	s3,0(t2)
aaaaf7a0:	0044a483          	lw	s1,4(s1)
aaaaf7a4:	0093a223          	sw	s1,4(t2)
aaaaf7a8:	00ff87b3          	add	a5,t6,a5
aaaaf7ac:	00d787b3          	add	a5,a5,a3
aaaaf7b0:	01d78023          	sb	t4,0(a5)
aaaaf7b4:	00777393          	andi	t2,a4,7
aaaaf7b8:	00375793          	srli	a5,a4,0x3
aaaaf7bc:	00090693          	mv	a3,s2
aaaaf7c0:	0037f793          	andi	a5,a5,3
aaaaf7c4:	f6c39ee3          	bne	t2,a2,aaaaf740 <main+0x1910>
aaaaf7c8:	00279793          	slli	a5,a5,0x2
aaaaf7cc:	00f587b3          	add	a5,a1,a5
aaaaf7d0:	0207a483          	lw	s1,32(a5)
aaaaf7d4:	f8dff06f          	j	aaaaf760 <main+0x1930>
aaaaf7d8:	00168713          	addi	a4,a3,1
aaaaf7dc:	38039863          	bnez	t2,aaaafb6c <main+0x1d3c>
aaaaf7e0:	7d000893          	li	a7,2000
aaaaf7e4:	02e8d8b3          	divu	a7,a7,a4
aaaaf7e8:	00002f17          	auipc	t5,0x2
aaaaf7ec:	818f0f13          	addi	t5,t5,-2024 # aaab1000 <static_memblk>
aaaaf7f0:	36069a63          	bnez	a3,aaaafb64 <main+0x1d34>
aaaaf7f4:	00c11e83          	lh	t4,12(sp)
aaaaf7f8:	02012f83          	lw	t6,32(sp)
aaaaf7fc:	fff88293          	addi	t0,a7,-1
aaaaf800:	031787b3          	mul	a5,a5,a7
aaaaf804:	00ff07b3          	add	a5,t5,a5
aaaaf808:	00f12e23          	sw	a5,28(sp)
aaaaf80c:	34069063          	bnez	a3,aaaafb4c <main+0x1d1c>
aaaaf810:	00000393          	li	t2,0
aaaaf814:	00e11783          	lh	a5,14(sp)
aaaaf818:	01c12703          	lw	a4,28(sp)
aaaaf81c:	01079793          	slli	a5,a5,0x10
aaaaf820:	fff70a93          	addi	s5,a4,-1
aaaaf824:	ffcafa93          	andi	s5,s5,-4
aaaaf828:	01d7e7b3          	or	a5,a5,t4
aaaaf82c:	004a8a93          	addi	s5,s5,4
aaaaf830:	00079463          	bnez	a5,aaaaf838 <main+0x1a08>
aaaaf834:	00100793          	li	a5,1
aaaaf838:	00000513          	li	a0,0
aaaaf83c:	00050493          	mv	s1,a0
aaaaf840:	00150513          	addi	a0,a0,1
aaaaf844:	02a50733          	mul	a4,a0,a0
aaaaf848:	00371713          	slli	a4,a4,0x3
aaaaf84c:	ff1768e3          	bltu	a4,a7,aaaaf83c <main+0x1a0c>
aaaaf850:	02948b33          	mul	s6,s1,s1
aaaaf854:	001b1b13          	slli	s6,s6,0x1
aaaaf858:	016a8c33          	add	s8,s5,s6
aaaaf85c:	28048463          	beqz	s1,aaaafae4 <main+0x1cb4>
aaaaf860:	00149b93          	slli	s7,s1,0x1
aaaaf864:	000c0993          	mv	s3,s8
aaaaf868:	00100693          	li	a3,1
aaaaf86c:	00000913          	li	s2,0
aaaaf870:	418a8e33          	sub	t3,s5,s8
aaaaf874:	00068a13          	mv	s4,a3
aaaaf878:	00098613          	mv	a2,s3
aaaaf87c:	02f687b3          	mul	a5,a3,a5
aaaaf880:	01069713          	slli	a4,a3,0x10
aaaaf884:	01075713          	srli	a4,a4,0x10
aaaaf888:	00ce05b3          	add	a1,t3,a2
aaaaf88c:	00168693          	addi	a3,a3,1
aaaaf890:	00260613          	addi	a2,a2,2
aaaaf894:	41f7dc93          	srai	s9,a5,0x1f
aaaaf898:	010cdc93          	srli	s9,s9,0x10
aaaaf89c:	019787b3          	add	a5,a5,s9
aaaaf8a0:	01079793          	slli	a5,a5,0x10
aaaaf8a4:	0107d793          	srli	a5,a5,0x10
aaaaf8a8:	419787b3          	sub	a5,a5,s9
aaaaf8ac:	00f70cb3          	add	s9,a4,a5
aaaaf8b0:	010c9c93          	slli	s9,s9,0x10
aaaaf8b4:	010cdc93          	srli	s9,s9,0x10
aaaaf8b8:	00ec8733          	add	a4,s9,a4
aaaaf8bc:	ff961f23          	sh	s9,-2(a2)
aaaaf8c0:	0ff77713          	zext.b	a4,a4
aaaaf8c4:	00e59023          	sh	a4,0(a1)
aaaaf8c8:	faa69ae3          	bne	a3,a0,aaaaf87c <main+0x1a4c>
aaaaf8cc:	00190913          	addi	s2,s2,1
aaaaf8d0:	014486b3          	add	a3,s1,s4
aaaaf8d4:	00950533          	add	a0,a0,s1
aaaaf8d8:	017989b3          	add	s3,s3,s7
aaaaf8dc:	f8991ce3          	bne	s2,s1,aaaaf874 <main+0x1a44>
aaaaf8e0:	016c07b3          	add	a5,s8,s6
aaaaf8e4:	fff78793          	addi	a5,a5,-1
aaaaf8e8:	ffc7f793          	andi	a5,a5,-4
aaaaf8ec:	00478793          	addi	a5,a5,4
aaaaf8f0:	04f12023          	sw	a5,64(sp)
aaaaf8f4:	03512c23          	sw	s5,56(sp)
aaaaf8f8:	03812e23          	sw	s8,60(sp)
aaaaf8fc:	02912a23          	sw	s1,52(sp)
aaaaf900:	e01ff06f          	j	aaaaf700 <main+0x18d0>
aaaaf904:	00568913          	addi	s2,a3,5
aaaaf908:	10596863          	bltu	s2,t0,aaaafa18 <main+0x1be8>
aaaaf90c:	0116e463          	bltu	a3,a7,aaaaf914 <main+0x1ae4>
aaaaf910:	e28fe06f          	j	aaaadf38 <main+0x108>
aaaaf914:	00168713          	addi	a4,a3,1
aaaaf918:	00070593          	mv	a1,a4
aaaaf91c:	00e8beb3          	sltu	t4,a7,a4
aaaaf920:	40d887b3          	sub	a5,a7,a3
aaaaf924:	00100513          	li	a0,1
aaaaf928:	00e8e463          	bltu	a7,a4,aaaaf930 <main+0x1b00>
aaaaf92c:	00078513          	mv	a0,a5
aaaaf930:	fff78793          	addi	a5,a5,-1
aaaaf934:	00df83b3          	add	t2,t6,a3
aaaaf938:	0067b613          	sltiu	a2,a5,6
aaaaf93c:	40700e33          	neg	t3,t2
aaaaf940:	003e7793          	andi	a5,t3,3
aaaaf944:	06061663          	bnez	a2,aaaaf9b0 <main+0x1b80>
aaaaf948:	060e9463          	bnez	t4,aaaaf9b0 <main+0x1b80>
aaaaf94c:	18078063          	beqz	a5,aaaafacc <main+0x1c9c>
aaaaf950:	00038023          	sb	zero,0(t2)
aaaaf954:	002e7e13          	andi	t3,t3,2
aaaaf958:	020e0263          	beqz	t3,aaaaf97c <main+0x1b4c>
aaaaf95c:	00ef8733          	add	a4,t6,a4
aaaaf960:	00070023          	sb	zero,0(a4)
aaaaf964:	00300713          	li	a4,3
aaaaf968:	00268593          	addi	a1,a3,2
aaaaf96c:	00e79863          	bne	a5,a4,aaaaf97c <main+0x1b4c>
aaaaf970:	00bf85b3          	add	a1,t6,a1
aaaaf974:	00058023          	sb	zero,0(a1)
aaaaf978:	00e685b3          	add	a1,a3,a4
aaaaf97c:	40f50533          	sub	a0,a0,a5
aaaaf980:	00f687b3          	add	a5,a3,a5
aaaaf984:	00ff87b3          	add	a5,t6,a5
aaaaf988:	ffc57613          	andi	a2,a0,-4
aaaaf98c:	00c78733          	add	a4,a5,a2
aaaaf990:	0007a023          	sw	zero,0(a5)
aaaaf994:	00478793          	addi	a5,a5,4
aaaaf998:	fee79ce3          	bne	a5,a4,aaaaf990 <main+0x1b60>
aaaaf99c:	00c586b3          	add	a3,a1,a2
aaaaf9a0:	00c51463          	bne	a0,a2,aaaaf9a8 <main+0x1b78>
aaaaf9a4:	d94fe06f          	j	aaaadf38 <main+0x108>
aaaaf9a8:	00168713          	addi	a4,a3,1
aaaaf9ac:	00df83b3          	add	t2,t6,a3
aaaaf9b0:	00038023          	sb	zero,0(t2)
aaaaf9b4:	01176463          	bltu	a4,a7,aaaaf9bc <main+0x1b8c>
aaaaf9b8:	d80fe06f          	j	aaaadf38 <main+0x108>
aaaaf9bc:	00ef8733          	add	a4,t6,a4
aaaaf9c0:	00070023          	sb	zero,0(a4)
aaaaf9c4:	00268793          	addi	a5,a3,2
aaaaf9c8:	0117e463          	bltu	a5,a7,aaaaf9d0 <main+0x1ba0>
aaaaf9cc:	d6cfe06f          	j	aaaadf38 <main+0x108>
aaaaf9d0:	00ff87b3          	add	a5,t6,a5
aaaaf9d4:	00078023          	sb	zero,0(a5)
aaaaf9d8:	00368793          	addi	a5,a3,3
aaaaf9dc:	0117e463          	bltu	a5,a7,aaaaf9e4 <main+0x1bb4>
aaaaf9e0:	d58fe06f          	j	aaaadf38 <main+0x108>
aaaaf9e4:	00ff87b3          	add	a5,t6,a5
aaaaf9e8:	00078023          	sb	zero,0(a5)
aaaaf9ec:	00468793          	addi	a5,a3,4
aaaaf9f0:	0117e463          	bltu	a5,a7,aaaaf9f8 <main+0x1bc8>
aaaaf9f4:	d44fe06f          	j	aaaadf38 <main+0x108>
aaaaf9f8:	00ff87b3          	add	a5,t6,a5
aaaaf9fc:	00078023          	sb	zero,0(a5)
aaaafa00:	00568693          	addi	a3,a3,5
aaaafa04:	0116e463          	bltu	a3,a7,aaaafa0c <main+0x1bdc>
aaaafa08:	d30fe06f          	j	aaaadf38 <main+0x108>
aaaafa0c:	00df86b3          	add	a3,t6,a3
aaaafa10:	00068023          	sb	zero,0(a3)
aaaafa14:	d24fe06f          	j	aaaadf38 <main+0x108>
aaaafa18:	00000397          	auipc	t2,0x0
aaaafa1c:	69838393          	addi	t2,t2,1688 # aaab00b0 <floatpat>
aaaafa20:	00279793          	slli	a5,a5,0x2
aaaafa24:	00f387b3          	add	a5,t2,a5
aaaafa28:	0307a483          	lw	s1,48(a5)
aaaafa2c:	00170713          	addi	a4,a4,1
aaaafa30:	00df83b3          	add	t2,t6,a3
aaaafa34:	0004c783          	lbu	a5,0(s1)
aaaafa38:	01071713          	slli	a4,a4,0x10
aaaafa3c:	01075713          	srli	a4,a4,0x10
aaaafa40:	00f38023          	sb	a5,0(t2)
aaaafa44:	00168993          	addi	s3,a3,1
aaaafa48:	00400793          	li	a5,4
aaaafa4c:	0014ca83          	lbu	s5,1(s1)
aaaafa50:	013f89b3          	add	s3,t6,s3
aaaafa54:	00400a13          	li	s4,4
aaaafa58:	01598023          	sb	s5,0(s3)
aaaafa5c:	0024c983          	lbu	s3,2(s1)
aaaafa60:	01338123          	sb	s3,2(t2)
aaaafa64:	0034c983          	lbu	s3,3(s1)
aaaafa68:	013381a3          	sb	s3,3(t2)
aaaafa6c:	d3478ee3          	beq	a5,s4,aaaaf7a8 <main+0x1978>
aaaafa70:	0044c983          	lbu	s3,4(s1)
aaaafa74:	00800793          	li	a5,8
aaaafa78:	01338223          	sb	s3,4(t2)
aaaafa7c:	0054c983          	lbu	s3,5(s1)
aaaafa80:	013382a3          	sb	s3,5(t2)
aaaafa84:	0064c983          	lbu	s3,6(s1)
aaaafa88:	01338323          	sb	s3,6(t2)
aaaafa8c:	0074c483          	lbu	s1,7(s1)
aaaafa90:	009383a3          	sb	s1,7(t2)
aaaafa94:	d15ff06f          	j	aaaaf7a8 <main+0x1978>
aaaafa98:	00279793          	slli	a5,a5,0x2
aaaafa9c:	00f587b3          	add	a5,a1,a5
aaaafaa0:	0107a483          	lw	s1,16(a5)
aaaafaa4:	cbdff06f          	j	aaaaf760 <main+0x1930>
aaaafaa8:	00060713          	mv	a4,a2
aaaafaac:	bf1ff06f          	j	aaaaf69c <main+0x186c>
aaaafab0:	00068613          	mv	a2,a3
aaaafab4:	a41ff06f          	j	aaaaf4f4 <main+0x16c4>
aaaafab8:	0004ca03          	lbu	s4,0(s1)
aaaafabc:	00168993          	addi	s3,a3,1
aaaafac0:	00800793          	li	a5,8
aaaafac4:	01438023          	sb	s4,0(t2)
aaaafac8:	f85ff06f          	j	aaaafa4c <main+0x1c1c>
aaaafacc:	00068593          	mv	a1,a3
aaaafad0:	eadff06f          	j	aaaaf97c <main+0x1b4c>
aaaafad4:	00060693          	mv	a3,a2
aaaafad8:	00078593          	mv	a1,a5
aaaafadc:	00000613          	li	a2,0
aaaafae0:	99dff06f          	j	aaaaf47c <main+0x164c>
aaaafae4:	00000b13          	li	s6,0
aaaafae8:	df9ff06f          	j	aaaaf8e0 <main+0x1ab0>
aaaafaec:	00168713          	addi	a4,a3,1
aaaafaf0:	7d000893          	li	a7,2000
aaaafaf4:	02e8d8b3          	divu	a7,a7,a4
aaaafaf8:	06069263          	bnez	a3,aaaafb5c <main+0x1d2c>
aaaafafc:	00001f17          	auipc	t5,0x1
aaaafb00:	504f0f13          	addi	t5,t5,1284 # aaab1000 <static_memblk>
aaaafb04:	00c11e83          	lh	t4,12(sp)
aaaafb08:	fff88293          	addi	t0,a7,-1
aaaafb0c:	031687b3          	mul	a5,a3,a7
aaaafb10:	00ff07b3          	add	a5,t5,a5
aaaafb14:	02f12023          	sw	a5,32(sp)
aaaafb18:	00078f93          	mv	t6,a5
aaaafb1c:	bedff06f          	j	aaaaf708 <main+0x18d8>
aaaafb20:	00100693          	li	a3,1
aaaafb24:	031787b3          	mul	a5,a5,a7
aaaafb28:	00c11e83          	lh	t4,12(sp)
aaaafb2c:	fff88293          	addi	t0,a7,-1
aaaafb30:	00400393          	li	t2,4
aaaafb34:	03170fb3          	mul	t6,a4,a7
aaaafb38:	00ff07b3          	add	a5,t5,a5
aaaafb3c:	00f12e23          	sw	a5,28(sp)
aaaafb40:	01ff0fb3          	add	t6,t5,t6
aaaafb44:	03f12023          	sw	t6,32(sp)
aaaafb48:	cc0686e3          	beqz	a3,aaaaf814 <main+0x19e4>
aaaafb4c:	00200a13          	li	s4,2
aaaafb50:	8b5ff06f          	j	aaaaf404 <main+0x15d4>
aaaafb54:	06600813          	li	a6,102
aaaafb58:	b5cfe06f          	j	aaaadeb4 <main+0x84>
aaaafb5c:	00068713          	mv	a4,a3
aaaafb60:	b68fe06f          	j	aaaadec8 <main+0x98>
aaaafb64:	01e12c23          	sw	t5,24(sp)
aaaafb68:	c8dff06f          	j	aaaaf7f4 <main+0x19c4>
aaaafb6c:	00268613          	addi	a2,a3,2
aaaafb70:	7d000893          	li	a7,2000
aaaafb74:	02c8d8b3          	divu	a7,a7,a2
aaaafb78:	02069463          	bnez	a3,aaaafba0 <main+0x1d70>
aaaafb7c:	00001f17          	auipc	t5,0x1
aaaafb80:	484f0f13          	addi	t5,t5,1156 # aaab1000 <static_memblk>
aaaafb84:	fa1ff06f          	j	aaaafb24 <main+0x1cf4>
aaaafb88:	001e0e13          	addi	t3,t3,1
aaaafb8c:	96ae04e3          	beq	t3,a0,aaaaf4f4 <main+0x16c4>
aaaafb90:	00068493          	mv	s1,a3
aaaafb94:	00058993          	mv	s3,a1
aaaafb98:	00060693          	mv	a3,a2
aaaafb9c:	945ff06f          	j	aaaaf4e0 <main+0x16b0>
aaaafba0:	00200a13          	li	s4,2
aaaafba4:	b24fe06f          	j	aaaadec8 <main+0x98>

aaaafba8 <_text_vma_end>:
	...

Disassembly of section .data:

aaab0000 <_data_vma_start>:
aaab0000:	3054                	.insn	2, 0x3054
aaab0002:	332e                	.insn	2, 0x332e
aaab0004:	2d65                	.insn	2, 0x2d65
aaab0006:	4631                	.insn	2, 0x4631
aaab0008:	0000                	.insn	2, 0x
aaab000a:	0000                	.insn	2, 0x
aaab000c:	542d                	.insn	2, 0x542d
aaab000e:	542e                	.insn	2, 0x542e
aaab0010:	71542b2b          	.insn	4, 0x71542b2b
aaab0014:	0000                	.insn	2, 0x
aaab0016:	0000                	.insn	2, 0x
aaab0018:	5431                	.insn	2, 0x5431
aaab001a:	65342e33          	.insn	4, 0x65342e33
aaab001e:	7a34                	.insn	2, 0x7a34
aaab0020:	0000                	.insn	2, 0x
aaab0022:	0000                	.insn	2, 0x
aaab0024:	302e3433          	.insn	4, 0x302e3433
aaab0028:	2d65                	.insn	2, 0x2d65
aaab002a:	5e54                	.insn	2, 0x5e54
aaab002c:	0000                	.insn	2, 0x
aaab002e:	0000                	.insn	2, 0x
aaab0030:	2e35                	.insn	2, 0x2e35
aaab0032:	3035                	.insn	2, 0x3035
aaab0034:	6530                	.insn	2, 0x6530
aaab0036:	0000332b          	.insn	4, 0x332b
aaab003a:	0000                	.insn	2, 0x
aaab003c:	2e2d                	.insn	2, 0x2e2d
aaab003e:	3231                	.insn	2, 0x3231
aaab0040:	322d6533          	.insn	4, 0x322d6533
aaab0044:	0000                	.insn	2, 0x
aaab0046:	0000                	.insn	2, 0x
aaab0048:	382d                	.insn	2, 0x382d
aaab004a:	382b6537          	lui	a0,0x382b6
aaab004e:	00003233          	snez	tp,zero
aaab0052:	0000                	.insn	2, 0x
aaab0054:	362e302b          	.insn	4, 0x362e302b
aaab0058:	2d65                	.insn	2, 0x2d65
aaab005a:	3231                	.insn	2, 0x3231
aaab005c:	0000                	.insn	2, 0x
aaab005e:	0000                	.insn	2, 0x
aaab0060:	352e3533          	.insn	4, 0x352e3533
aaab0064:	3434                	.insn	2, 0x3434
aaab0066:	3030                	.insn	2, 0x3030
aaab0068:	0000                	.insn	2, 0x
aaab006a:	0000                	.insn	2, 0x
aaab006c:	312e                	.insn	2, 0x312e
aaab006e:	3332                	.insn	2, 0x3332
aaab0070:	3534                	.insn	2, 0x3534
aaab0072:	3030                	.insn	2, 0x3030
aaab0074:	0000                	.insn	2, 0x
aaab0076:	0000                	.insn	2, 0x
aaab0078:	312d                	.insn	2, 0x312d
aaab007a:	3031                	.insn	2, 0x3031
aaab007c:	372e                	.insn	2, 0x372e
aaab007e:	3030                	.insn	2, 0x3030
aaab0080:	0000                	.insn	2, 0x
aaab0082:	0000                	.insn	2, 0x
aaab0084:	362e302b          	.insn	4, 0x362e302b
aaab0088:	3434                	.insn	2, 0x3434
aaab008a:	3030                	.insn	2, 0x3030
aaab008c:	0000                	.insn	2, 0x
aaab008e:	0000                	.insn	2, 0x
aaab0090:	3035                	.insn	2, 0x3035
aaab0092:	3231                	.insn	2, 0x3231
aaab0094:	0000                	.insn	2, 0x
aaab0096:	0000                	.insn	2, 0x
aaab0098:	3231                	.insn	2, 0x3231
aaab009a:	00003433          	snez	s0,zero
aaab009e:	0000                	.insn	2, 0x
aaab00a0:	382d                	.insn	2, 0x382d
aaab00a2:	00003437          	lui	s0,0x3
aaab00a6:	0000                	.insn	2, 0x
aaab00a8:	3232312b          	.insn	4, 0x3232312b
aaab00ac:	0000                	.insn	2, 0x
	...

aaab00b0 <floatpat>:
aaab00b0:	0060                	.insn	2, 0x0060
aaab00b2:	006caaab          	.insn	4, 0x006caaab
aaab00b6:	0078aaab          	.insn	4, 0x0078aaab
aaab00ba:	0084aaab          	.insn	4, 0x0084aaab
aaab00be:	          	.insn	4, 0x0030aaab

aaab00c0 <scipat>:
aaab00c0:	0030                	.insn	2, 0x0030
aaab00c2:	003caaab          	.insn	4, 0x003caaab
aaab00c6:	0048aaab          	.insn	4, 0x0048aaab
aaab00ca:	0054aaab          	.insn	4, 0x0054aaab
aaab00ce:	          	.insn	4, 0xaaab

aaab00d0 <errpat>:
aaab00d0:	0000                	.insn	2, 0x
aaab00d2:	000caaab          	.insn	4, 0x000caaab
aaab00d6:	0018aaab          	.insn	4, 0x0018aaab
aaab00da:	0024aaab          	.insn	4, 0x0024aaab
aaab00de:	          	.insn	4, 0x0090aaab

aaab00e0 <intpat>:
aaab00e0:	0090                	.insn	2, 0x0090
aaab00e2:	0098aaab          	.insn	4, 0x0098aaab
aaab00e6:	00a0aaab          	.insn	4, 0x00a0aaab
aaab00ea:	00a8aaab          	.insn	4, 0x00a8aaab
aaab00ee:	          	.insn	4, 0x0001aaab

aaab00f0 <seed4_volatile>:
aaab00f0:	0001                	.insn	2, 0x0001
	...

aaab00f4 <seed3_volatile>:
aaab00f4:	0066                	.insn	2, 0x0066
	...

aaab00f8 <_data_vma_end>:
	...
