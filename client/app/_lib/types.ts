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

export interface Components {
  "1": File | null;
  "2": File | null;
  "3": File | null;
  "4": File | null;
  "5": File | null;
  "6": File | null;
  "7": File | null;
  "8": File | null;
}
