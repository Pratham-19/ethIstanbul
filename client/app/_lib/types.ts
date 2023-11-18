export enum QuestStatus {
  Active = "active",
  Ended = "ended",
}
export interface PartnerDashboardQuest {
  img: string;
  title: string;
  timer: string;
  participants: string;
  bounty: string;
  status: QuestStatus;
}
