import { useMUD } from "../MUDContext";

export const useGoldBalance = () => {
  const {
    components: { Balances },
  } = useMUD();
  console.log(Balances);
  
};

export default useGoldBalance;